//
//  Analytics.m
//  TealiumDemo
//
//  Created by Jason Koo on 7/13/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//

#import "TealiumIQ.h"

NSString * const kTealiumConfigKey = @"tealiumConfig";
NSString * const kTealiumAccountKey = @"tealiumAccount";
NSString * const kTealiumProfileKey =  @"tealiumProfile";
NSString * const kTealiumEnvironmentKey = @"tealiumEnvironment";

@implementation TealiumIQ

#pragma mark - CONFIGURATION

/*
 This is the default account-profile-environment used at start-up.  Can be overwritten from the Settings View.
 
 ========
 EDITABLE
 ========
 
 */
+ (NSDictionary*) tealiumConfigDefault{
    return @{
             kTealiumAccountKey:@"tealiummobile",
             kTealiumProfileKey:@"demo",
             kTealiumEnvironmentKey:@"dev"
             };
}

/*
 Unarchives any saved account-profile-environment saved from Settings View
 
 ===========
 DO NOT EDIT
 ===========
 
 */
+ (NSDictionary*) tealiumConfig{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *config = [defaults objectForKey:kTealiumConfigKey];
    if (config) {
        return config;
    }
    return [self tealiumConfigDefault];
}


/*
 Initializes the Tealium library
 
 ===========
 DO NOT EDIT
 ===========
 
 */
+ (void) start{
    NSDictionary *config = [TealiumIQ tealiumConfig];
    
    NSString *account = config[kTealiumAccountKey];
    NSString *profile = config[kTealiumProfileKey];
    NSString *env = config[kTealiumEnvironmentKey];
        
    [Tealium initSharedInstance:account
                        profile:profile
                         target:env
                        options:TLDisplayVerboseLogs
               globalCustomData:nil];

}

/*
 Resets library to defaults
 
 ===========
 DO NOT EDIT
 ===========
 
 */
+ (void) restart{
    NSDictionary *config = [TealiumIQ tealiumConfigDefault];
    
    NSString *account = config[kTealiumAccountKey];
    NSString *profile = config[kTealiumProfileKey];
    NSString *env = config[kTealiumEnvironmentKey];
    
    [self saveAccount:account
              profile:profile
                  env:env];
    
    [self start];
}
/*
 Archives any account-profile-environment to persistence - so that it can be called up at start time if different than defaults.
 
 ===========
 DO NOT EDIT
 ===========
 
 */
+ (BOOL) saveAccount:(NSString*)account profile:(NSString*)profile env:(NSString*)env{
    
    if (!account || [account isEqualToString:@""]){
        return NO;
    }
    
    if (!profile || [profile isEqualToString:@""]){
        return NO;
    }
    
    if (!env || [env isEqualToString:@""]){
        return NO;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *config = @{
                             kTealiumAccountKey:account,
                             kTealiumProfileKey:profile,
                             kTealiumEnvironmentKey:env
                             };
    [defaults setObject:config forKey:kTealiumConfigKey];
    return YES;
}

#pragma mark - TRACKING

/*
 Example of a basic event / link track call
 */
+ (void) trackEvent{
    [Tealium trackCallType:TealiumEventCall
                customData:@{@"event_name":@"Sample Event"}
                    object:nil];
}

/*
 Example of a basic view / page change track call
 */
+ (void) trackView{
    [Tealium trackCallType:TealiumViewCall
                customData:@{@"page_type":@"Sample View"}
                    object:nil];
}

/*
 Example link call with custom data
 
 param data Any custom data source key-values to pass along to the data layer
 */
+ (void) trackEventWithCustomData:(NSDictionary *)data{
    
    NSMutableDictionary *customData = [NSMutableDictionary dictionary];
    customData[@"event_name"] = @"Sample Event with Custom Data";
    [customData addEntriesFromDictionary:data];
    
    [Tealium trackCallType:TealiumEventCall
                customData:customData
                    object:nil];
}

/*
 Example view call with Custom Data
 
 param data Any custom data source key-values to pass along to the data layer
 */
+ (void) trackViewWithCustomData:(NSDictionary *)data{
    
    NSMutableDictionary *customData = [NSMutableDictionary dictionary];
    customData[@"page_type"] = @"Sample View with Custom Data";
    [customData addEntriesFromDictionary:data];
    [Tealium trackCallType:TealiumViewCall
                customData:data
                    object:nil];
}

/*
 Example demonstrating the libraries object autotracking capabilities
 
 param object Any NSObject subclass - includes all standard User Interface objects such as UIButtons, UISwitches, etc.
 */
+ (void) trackEventWithObject:(NSObject *)object{
    
    [Tealium trackCallType:TealiumEventCall
                customData:@{@"event_name":@"Sample Event with Autotracked Object data"}
                    object:object];
}

/*
 Example event call but adding in an associated view controller title with call
 
 param viewController Any UIViewController or subclass
 */
+ (void) trackEventWithAssociatedView:(UIViewController *)viewController{
    
    NSString *title = viewController.title;
    
    [Tealium trackCallType:TealiumEventCall
                customData:@{@"event_name":@"Sample Event with associated view controller",
                            @"associated_page_type":title}
                    object:viewController];
}

/*
 Example demonstrating the libraries object autotracking capabilities for view controllers
 
 param viewController Any UIViewController subclass - These are the classes that normally control how views (or pages) appear on mobile devices
 */
+ (void) trackViewController:(UIViewController *)viewController{
    
    [Tealium trackCallType:TealiumViewCall
                customData:@{@"event_name":@"Sample View with Autotracked object data"}
                    object:viewController];
}

/*
 Example reserved TagBridge command "_mobilecompanion" demonstrator. This only sends an event call with a custom data source which can be keyed off to trigger the TB command.  The custom data source value here does not matter and can be of ANY value, as the actual check is done in TIQ.
 
 */
+ (void) launchMobileCompanion{
    [Tealium trackCallType:TealiumEventCall
                customData:@{@"event_name":@"reveal"}
                    object:nil];
}
@end
