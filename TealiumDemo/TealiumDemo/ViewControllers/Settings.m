//
//  Settings.m
//  TealiumDemo
//
//  Created by Jason Koo on 7/10/15.
//  Copyright (c) 2015 teailum. All rights reserved.
//

#import "Settings.h"
#import "FormItemCell.h"
#import "ButtonCell.h"

@interface Settings () <UITextFieldDelegate>

@end

@implementation Settings

typedef NS_ENUM(NSInteger, SettingsItem){
    SettingsItemAccount = 0,
    SettingsItemProfile,
    SettingsItemEnvironment,
    SettingsItemSave,
    SettingsItemDefault,
    SettingsItemNumberOfItems
};

- (void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"Settings";
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [Tealium trackCallType:TealiumViewCall
                customData:nil
                    object:self];
    
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return SettingsItemNumberOfItems;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case SettingsItemAccount:
        case SettingsItemProfile:
        case SettingsItemEnvironment:
        {
            FormItemCell *formCell = [tableView dequeueReusableCellWithIdentifier:@"formItemCell"];
            [self prepareFormItemCell:formCell ForIndexPath:indexPath];
            formCell.formTextField.tag = indexPath.row;
            formCell.formTextField.delegate = self;
            cell = formCell;
        }
            break;
        case SettingsItemSave:
        case SettingsItemDefault:
        {
            ButtonCell *buttonCell = [tableView dequeueReusableCellWithIdentifier:@"buttonCell"];
            [self prepareButtonCell:buttonCell ForIndexPath:indexPath];
            cell = buttonCell;
        }
            break;
        default:
            break;
    }
    return cell;
}


- (void) prepareFormItemCell:(FormItemCell*)formCell ForIndexPath:(NSIndexPath*) indexPath{
    switch (indexPath.row) {
        case SettingsItemAccount:
            formCell.formLabel.text = @"Account";
            
            // TODO: load persistence + defaults here
            formCell.formTextField.placeholder = @"";
            break;
        case SettingsItemProfile:
            formCell.formLabel.text = @"Profile";
            
            // TODO: load persistence + defaults here
            formCell.formTextField.placeholder = @"";
            break;
        case SettingsItemEnvironment:
            formCell.formLabel.text = @"Environment";
            
            // TODO: load persistence + defaults here
            formCell.formTextField.placeholder = @"";
            break;
        default:
            NSLog(@"Unsupported Cell returned.");
            break;
    }
    
}

- (void) prepareButtonCell:(ButtonCell*)buttonCell ForIndexPath:(NSIndexPath*) indexPath{
    
    switch (indexPath.row){
            
        case SettingsItemSave:
            buttonCell.titleLabel.text = @"Save";
            break;
        case SettingsItemDefault:
            buttonCell.titleLabel.text = @"Default";
            break;
        default:
            break;
            
    }
    
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case SettingsItemSave:
            // TODO:
            break;
        case SettingsItemDefault:
            
            break;
        default:
            break;
    }
}

#pragma mark - UITEXTFIELD DELEGATE

- (BOOL) textFieldShouldReturn:(UITextField*)textField{
    
    switch (textField.tag) {
        case SettingsItemAccount:
        {
            NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:SettingsItemProfile inSection:0];
            FormItemCell *cell = (FormItemCell*)[self.tableView cellForRowAtIndexPath:sourcePath];
            if (cell){
                [cell.formTextField becomeFirstResponder];
            }
        }
            break;
        case SettingsItemProfile:
        {
            NSIndexPath *sourcePath = [NSIndexPath indexPathForRow:SettingsItemEnvironment inSection:0];
            FormItemCell *cell = (FormItemCell*)[self.tableView cellForRowAtIndexPath:sourcePath];
            if (cell){
                [cell.formTextField becomeFirstResponder];
            }
        }
            break;
            
        case SettingsItemEnvironment:
            [textField resignFirstResponder];
            
            break;
        default:
            break;
    }
    return true;
}

@end
