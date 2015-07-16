//
//  APISampler.m
//  TealiumDemo
//
//  Created by Jason Koo on 7/10/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//

#import "APISampler.h"
#import "TealiumIQ.h"

@interface APISampler () <UIAlertViewDelegate>

@property (copy, nonatomic) NSString *customValue;

@end

@implementation APISampler

typedef NS_ENUM(NSInteger, ApiSamplerItem){
    ApiSamplerItemSendEvent = 0,
    ApiSamplerItemSendEvent2,
    ApiSamplerItemSendEvent3,
    ApiSamplerItemSendEvent4,
    ApiSamplerItemSendEvent5,
    ApiSamplerItemNumberOfItems
};


/*
 ========
 EDITABLE
 ========
 
 Modify the customValue property to demo iVar autotracking
 
 */
- (void) viewDidLoad{
    [super viewDidLoad];
#ifdef FULL
    NSString *title = [NSString stringWithFormat:@"%@ API Sampler", TealiumLibraryVersion];
#elif COMPACT
    NSString *title = NSLocalizedString(@"Compact API Sampler", @"");
#else
    NSString *title = NSLocalizedString(@"Collect API Sampler", @"");
#endif
    self.title = title;
    self.customValue = @"Custom property value";
}

/*
 ========
 EDITABLE
 ========
 */
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSDictionary *data = @{@"screen_title":self.title};
#ifndef COLLECT
    [Tealium trackCallType:TealiumViewCall
                customData:data
                    object:self];
#else
    [TealiumCollect sendViewWithData:data];
#endif
}

/*
 ========
 EDITABLE
 ========
 
 
 */
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case ApiSamplerItemSendEvent:
        {
            [TealiumIQ trackEvent];
        }
            break;
        case ApiSamplerItemSendEvent2:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter a custom value:"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
            [alert setAlertViewStyle: UIAlertViewStylePlainTextInput];
            [alert show];
        }

            break;
        case ApiSamplerItemSendEvent3:
            
        {
            [TealiumIQ trackEventWithObject:tableView];
        }
            break;
            
        case ApiSamplerItemSendEvent4:
        {
#ifdef FULL
            [TealiumIQ launchMobileCompanion];
#endif
        }
            break;
        default:
            break;
    }
    [self.tableView reloadData];
}


#pragma mark - ALERTVIEW DELEGATE

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"Button index tapped: %li", (long)buttonIndex);
    
    if (buttonIndex == 1){
        
        UITextField *field = [alertView textFieldAtIndex:0];
        NSDictionary *customData = @{@"event_name":@"Event with More Custom Data",
                                     @"associated_screen_title" : self.title,
                                     @"custom_value":field.text,
                                     @"selected_value":field.text};
        
#ifndef COLLECT
        [Tealium trackCallType:TealiumEventCall
                    customData:customData
                        object:nil];
#else
        [TealiumCollect sendEventWithData:customData];
#endif
        
    }
}

#pragma mark - TABLEVIEW DELEGATE

/*
 =========================
 DO NOT EDIT BELOW METHODS
 =========================
 */

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ApiSamplerItemNumberOfItems;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/*
 Edit this method only if wanting to change the cell titles
 */
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
#ifndef COLLECT
            cell.textLabel.text = @"Send Event with Object Data";
#endif
            break;
        case ApiSamplerItemSendEvent4:
#ifdef FULL
            cell.textLabel.text = @"Launch Mobile Companion";
#endif
            break;
            
        case ApiSamplerItemSendEvent5:
            break;
        default:
            break;
    }
    
    return cell;
}
@end
