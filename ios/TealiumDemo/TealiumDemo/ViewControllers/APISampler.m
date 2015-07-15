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
    self.title = @"API Sampler";
    self.customValue = @"Custom property value";
}

/*
 ========
 EDITABLE
 ========
 */
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [Tealium trackCallType:TealiumViewCall
                customData:@{@"screen_title":self.title}
                    object:self];
    
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
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Enter a name:"
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
            [TealiumIQ launchMobileCompanion];
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
            cell.textLabel.text = @"Send Event with Object Data";
            break;
            
        case ApiSamplerItemSendEvent4:
            cell.textLabel.text = @"Launch Mobile Companion";
            break;
            
        case ApiSamplerItemSendEvent5:
            break;
        default:
            break;
    }
    
    return cell;
}
@end
