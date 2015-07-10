//
//  APISampler.m
//  TealiumDemo
//
//  Created by Jason Koo on 7/10/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//

#import "APISampler.h"
#import <TealiumLibrary/Tealium.h>


@interface APISampler () <UIAlertViewDelegate>
@property (copy, nonatomic) NSString *customValue;
@end

@implementation APISampler

/*
 trackEvent
 trackEventWithCustom
 
 */

typedef NS_ENUM(NSInteger, ApiSamplerItem){
    ApiSamplerItemSendEvent = 0,
    ApiSamplerItemSendEvent2,
    ApiSamplerItemSendEvent3,
    ApiSamplerItemNumberOfItems
};


- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"API Sampler";
    
    self.customValue = @"Some custom value";
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [Tealium trackCallType:TealiumViewCall
                customData:@{@"screen_title":self.title}
                    object:self];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ApiSamplerItemNumberOfItems;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    switch (indexPath.row) {
        case ApiSamplerItemSendEvent:
            cell.textLabel.text = @"Send Event";
            break;
        case ApiSamplerItemSendEvent2:
            cell.textLabel.text = @"Send Custom Event";
            
            break;
        case ApiSamplerItemSendEvent3:
            cell.textLabel.text = @"Send Event 3";
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case ApiSamplerItemSendEvent:
        {
            
            NSDictionary *customData = @{@"event_name":@"Event with Custom Data",
                                         @"associated_screen_title" : self.title,
                                         @"customKey": @"customValue"};
            
            [Tealium trackCallType:TealiumEventCall
                        customData:customData
                            object:nil];
        }
            
            break;
        case ApiSamplerItemSendEvent2:
        {
            
            // TODO: property
            NSDictionary *customData = @{@"event_name":@"Event with Custom Data",
                                         @"associated_screen_title" : self.title,
                                         @"customKey": self.customValue};
            
            [Tealium trackCallType:TealiumEventCall
                        customData:customData
                            object:nil];
        }

            break;
        case ApiSamplerItemSendEvent3:
            
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter a name:"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
            [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
            [alert show];
            
            // TODO:  Displays alert for custom input

        }
            break;
        default:
            break;
    }
}


#pragma mark - ALERTVIEW DELEGATE

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Button index tapped: %li", (long)buttonIndex);
    
    if (buttonIndex == 1){
        
        UITextField *field = [alertView textFieldAtIndex:0];
        NSDictionary *customData = @{@"event_name":@"Event with More Custom Data",
                                     @"associated_screen_title" : self.title,
                                     @"name":field.text};
        
        [Tealium trackCallType:TealiumEventCall
                    customData:customData
                        object:nil];
        
    }
}

@end
