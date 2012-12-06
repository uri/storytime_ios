//
//  UGUserProfileViewController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-12-06.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGUserProfileViewController.h"

@interface UGUserProfileViewController ()

@end

@implementation UGUserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [_recentStories setDelegate:self];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_usernameLabel setText:_username];
    [_upvoteScoreLabel setText:_upvoteScore];
    [_downvoteScoreLabel setText:_downvoteScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view stuff

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    [[cell textLabel] setText:@"Test"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}


@end
