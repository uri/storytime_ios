//
//  UGLoginViewController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGLoginViewController.h"
#import "UGCreateAccountController.h"
#import "UGLoginManager.h"
#import "UGStoryCardViewController.h"

@interface UGLoginViewController ()

@end

@implementation UGLoginViewController

-(id) init {
    self = [super init];
    if (self) {
        [[self navigationItem] setTitle:@"Login"];
        [[UGLoginManager sharedInstance] setViewControllerDelegate: self];
    }
    
    return self;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:215.0/255.0 green:217.0/255.0 blue:223.0/255.0 alpha:1.0]];
}

-(void) loginAction
{
    [[UGLoginManager sharedInstance] loginAPI: [usernameField text] withPassword:[passwordField text]];
}

-(void) proceed
{
    UGStoryCardViewController *mainView = [[UGStoryCardViewController alloc] init];
    [[self navigationController] pushViewController:mainView animated:YES];
}

- (IBAction)loginPressed:(id)sender
{
    [self loginAction];
}

- (IBAction)createAccountPressed:(id)sender {
    UGCreateAccountController *createAccount = [[UGCreateAccountController alloc] init];
    [[self navigationController] pushViewController:createAccount animated:YES];
}

#pragma mark -
#pragma mark text field

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == usernameField) {
        [usernameField resignFirstResponder];
        [passwordField becomeFirstResponder];
    } else if (textField == passwordField) {
        [passwordField resignFirstResponder];
        [self loginAction];
    }
    return YES;
}
@end
