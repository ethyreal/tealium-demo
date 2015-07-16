//
//  Analytics.h
//  TealiumDemo
//
//  Created by Jason Koo on 7/13/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//
//  BRIEF: This is a convenience class to handle basic Tealium API calls - this paradigm of abstracting analytics commands to a separate object is NOT requried but is a recommended best practice.

#import <UIKit/UIKit.h>

#ifndef COLLECT
#import <TealiumLibrary/Tealium.h>
#else
#import <TealiumCollect/TealiumCollect.h>
#endif


extern NSString * const kTealiumConfigKey;
extern NSString * const kTealiumAccountKey;
extern NSString * const kTealiumProfileKey;
extern NSString * const kTealiumEnvironmentKey;

@interface TealiumIQ : NSObject

#pragma mark - CONFIGURATION

+ (NSDictionary*) tealiumConfig;
+ (void) start;
+ (void) restart;
+ (BOOL) saveAccount:(NSString*)account profile:(NSString*)profile env:(NSString*)env;

#pragma mark - TRACKING

+ (void) trackEvent;
+ (void) trackView;
+ (void) trackEventWithCustomData:(NSDictionary*)data;
+ (void) trackViewWithCustomData:(NSDictionary*)data;
+ (void) trackEventWithObject:(NSObject*)object;
+ (void) trackEventWithAssociatedView:(UIViewController*)viewController;
+ (void) trackViewController:(UIViewController*)viewController;
+ (void) launchMobileCompanion;

@end