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
#import "TealiumIQ.h"

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
            formCell.formLabel.text = NSLocalizedString(@"Account", @"");
            formCell.formTextField.text = [TealiumIQ tealiumConfig][kTealiumAccountKey];
            break;
        case SettingsItemProfile:
            formCell.formLabel.text = NSLocalizedString(@"Profile", @"");
            formCell.formTextField.text = [TealiumIQ tealiumConfig][kTealiumProfileKey];
            break;
        case SettingsItemEnvironment:
            formCell.formLabel.text = NSLocalizedString(@"Environment", @"");
            formCell.formTextField.text = [TealiumIQ tealiumConfig][kTealiumEnvironmentKey];
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
        {
            FormItemCell *accountCell = [self cellForSettingsItem:SettingsItemAccount];
            FormItemCell *profileCell = [self cellForSettingsItem:SettingsItemProfile];
            FormItemCell *environmentCell = [self cellForSettingsItem:SettingsItemEnvironment];
            
            NSString *account = accountCell.formTextField.text;
            NSString *profile = profileCell.formTextField.text;
            NSString *environment = environmentCell.formTextField.text;
            
            if (![TealiumIQ saveAccount:account
                                profile:profile
                                    env:environment]){
                // TODO: present user feedback that all settings must be filled out
                
                // TODO: replace with UIAlertController
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Account, Profile, and Environment setting required."
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                
            } else {
                
                [TealiumIQ restart];
                
                // TODO: replace with UIAlertController
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Library restarted with new account-profile-environment settings."
                                                                message:nil
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                [self.tableView reloadData];
            }
        }
            break;
        case SettingsItemDefault:
        {
            
            // TODO: replace with UIAlertController

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Library restarted with default account-profile-environment loaded."
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            [TealiumIQ restart];
            [self.tableView reloadData];
            
        }
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
            FormItemCell *cell = [self cellForSettingsItem:textField.tag];
            if (cell){
                [cell.formTextField becomeFirstResponder];
            }
        }
            break;
        case SettingsItemProfile:
        {
            FormItemCell *cell = [self cellForSettingsItem:textField.tag];
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

- (FormItemCell*) cellForSettingsItem:(SettingsItem) item{
    NSIndexPath *path = [NSIndexPath indexPathForRow:item inSection:0];
    if (!path){
        return nil;
    }
    
    FormItemCell *cell = (FormItemCell*)[self.tableView cellForRowAtIndexPath:path];
    return cell;
}

@end
