//
//  UGCreateAccountController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGCreateAccountController.h"
#import "UGLoginManager.h"

@interface UGCreateAccountController ()

@end

@implementation UGCreateAccountController

-(id) init
{
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle:@"Create an account"];
    }
    return self;
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:1.0]];
}


- (IBAction)createPressed:(id)sender
{
    [[UGLoginManager sharedInstance] createAccountAPI: [usernameField text]
                                         withPassword: [passwordField text]
                              andPasswordConfirmation: [confirmField text]];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == usernameField) {
        [usernameField resignFirstResponder];
        [passwordField becomeFirstResponder];
    } else if (textField == passwordField) {
        [passwordField resignFirstResponder];
        [confirmField becomeFirstResponder];
    } else if (textField == confirmField) {
        [confirmField resignFirstResponder];
        [[UGLoginManager sharedInstance] createAccountAPI: [usernameField text]
                                             withPassword: [passwordField text]
                                  andPasswordConfirmation: [confirmField text]];
    }
    
    return YES;
}
@end
