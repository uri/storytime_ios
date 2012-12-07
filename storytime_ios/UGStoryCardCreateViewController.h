//
//  UGStoryCardCreateViewController.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-12-06.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UGStoryCardCreateViewController : UIViewController <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;

@property (nonatomic, strong) NSString* originalText;
@property (nonatomic, strong) NSString* parentID;
@property (nonatomic, strong) IBOutlet UITextView* originalTextView;
@property (nonatomic, strong) IBOutlet UITextView* replyTextView;

- (IBAction)replyButtonPressed:(id)sender;
@end
