//
//  UGStoryCardCreateViewController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-12-06.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryCardCreateViewController.h"
#import "UGStoryTimeRestClient.h"
#import "UGStoryCardViewController.h"

@interface UGStoryCardCreateViewController ()

@end

@implementation UGStoryCardCreateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.navigationItem.title = @"Reply";
        _originalText = @"";
        _parentID = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [_replyTextView setText:@""];
    
    if ([_originalText isEqualToString:@""]) {
        [_originalTextView setHidden:YES];
    } else {
        [_originalTextView setText: _originalText];
        [_descriptionLabel setHidden:YES];
    }

}


- (IBAction)replyButtonPressed:(id)sender
{
    NSString* path = @"/story_cards.json";
    NSString* text = [_replyTextView text];
    NSDictionary* params = @{ @"story_card" : @{@"content" : text, @"parent_id" : _parentID}};
    
    NSLog(@"%@ : %@", path, params);
    
    [[UGStoryTimeRestClient sharedClient] getAPIFor:path withParams:params withHTTPMethodType:@"post" withSuccessBlock:^(id json) {
        [UIView beginAnimations:@"animations" context:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark -
#pragma mark TexView

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
