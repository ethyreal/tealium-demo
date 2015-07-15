//
//  FormItemCell.h
//  TealiumDemo
//
//  Created by Jason Koo on 7/10/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FormItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *formLabel;
@property (weak, nonatomic) IBOutlet UITextField *formTextField;

@end
