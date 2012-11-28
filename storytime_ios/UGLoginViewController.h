//
//  UGLoginViewController.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UGLoginViewController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UITextField *usernameField;
}
- (IBAction)loginPressed:(id)sender;
- (IBAction)createAccountPressed:(id)sender;

-(void) proceed;
@end
