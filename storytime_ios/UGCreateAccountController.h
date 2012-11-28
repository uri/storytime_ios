//
//  UGCreateAccountController.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UGCreateAccountController : UIViewController <UITextFieldDelegate>
{
    __weak IBOutlet UITextField *usernameField;
    __weak IBOutlet UITextField *confirmField;
    __weak IBOutlet UITextField *passwordField;
    __weak IBOutlet UILabel *errorLabel;
}
- (IBAction)createPressed:(id)sender;
@end
