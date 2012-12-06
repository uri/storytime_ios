//
//  UGUserProfileViewController.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-12-06.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UGUserProfileViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray* _topStories;
}

@property (weak, nonatomic) IBOutlet UITableView *recentStories;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *upvoteScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *downvoteScoreLabel;

@property (strong, nonatomic) NSString * upvoteScore;
@property (strong, nonatomic) NSString * downvoteScore;
@property (strong, nonatomic) NSString * username;

@end
