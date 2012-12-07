//
//  UGStoryCardViewController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryCardViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UGStoryCardManager.h"
#import "UGStoryCardItem.h"
#import "UGStoryCardTableViewCell.h"
#import "UGUserProfileViewController.h"
#import "UGStoryTimeRestClient.h"
#import "UGStoryCardCreateViewController.h"

@interface UGStoryCardViewController ()

@end

@implementation UGStoryCardViewController

-(id)initWithRootCard:(UGStoryCardItem*) rCard {
    // TODO: This might need to be changed to nib
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // Custom initialization
        cardManager = [[UGStoryCardManager alloc] init];
        [cardManager setViewControllerDelegate: self];
        [cardManager setRootCard:rCard];
        [cardManager requestCards];
        
        UIButton *replyBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        if (rCard)
            [replyBtn setTitle:@"Reply" forState:UIControlStateNormal];
        else
            [replyBtn setTitle:@"Post" forState:UIControlStateNormal];
        
        [replyBtn setFrame:CGRectMake(0, 0, 30, 30)];
        [replyBtn addTarget:self action:@selector(replyPressed) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.titleView = replyBtn;
    }
    return self;

}

-(id) init
{
    return [self initWithRootCard:nil];
}

-(void) reloadRequest
{
     self.navigationItem.rightBarButtonItem.enabled = NO;
    [SVProgressHUD setStatus:@"Refreshing..."];
    [SVProgressHUD show];
    [cardManager empty];
    [cardManager requestCards];
}

-(void) replyPressed
{
    UGStoryCardCreateViewController* createStoryCardVC = [[UGStoryCardCreateViewController alloc] init];
    
    if ([cardManager rootCard]) {
        [createStoryCardVC setOriginalText: [[cardManager rootCard] content]];
        [createStoryCardVC setParentID: [[[cardManager rootCard] cardID] stringValue]];
    }
    
    [UIView beginAnimations:@"Animations" context:nil];
    [self.navigationController pushViewController:createStoryCardVC animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[createStoryCardVC view] cache:NO];
    [UIView commitAnimations];

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadRequest)];
    [self reloadRequest];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[cardManager cards] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UGStoryCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UGStoryCardTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    UGStoryCardItem *storyCardAtRow = [[cardManager cards] objectAtIndex: [indexPath row]];
    [cell setStoryCard:storyCardAtRow];
    [cell setDelegate:self];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UGStoryCardItem *card = [[cardManager cards] objectAtIndex: [indexPath row]];
    UGStoryCardViewController *reply = [[UGStoryCardViewController alloc] initWithRootCard:card];
    [self.navigationController pushViewController:reply animated:YES];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UGStoryCardTableViewCell heightForCellWithStoryCard:[[cardManager cards] objectAtIndex:indexPath.row]];
}

#pragma mark -
#pragma mark TITableView

- (void)tableView:(UITableView *)tableView didSwipeCellAtIndexPath:(NSIndexPath *)indexPath {
	[super tableView:tableView didSwipeCellAtIndexPath:indexPath];
}


- (void)cellUpvoteWasTapped:(UGStoryCardTableViewCell *)cell {
    NSString *path  = [NSString stringWithFormat:@"/story_cards/%@/vote/1.json", [[[cell storyCard] cardID] stringValue]];
    NSLog(@"This is the path\n%@", path);
    [[UGStoryTimeRestClient sharedClient] getAPIFor:path withParams:@{} withHTTPMethodType:@"get" withSuccessBlock:^(id jsonResponse) {
        [self reloadRequest];
    }];
	
	[self hideVisibleBackView:YES];
}

- (void)cellDownvoteWasTapped:(UGStoryCardTableViewCell *)cell {
    NSString *path  = [NSString stringWithFormat:@"/story_cards/%@/vote/-1.json", [[[cell storyCard] cardID] stringValue]];
    [[UGStoryTimeRestClient sharedClient] getAPIFor:path withParams:@{} withHTTPMethodType:@"get" withSuccessBlock:^(id jsonResponse) {
        [self reloadRequest];
    }];
	
	[self hideVisibleBackView:YES];
}

- (void)cellProfileWasTapped:(UGStoryCardTableViewCell *)cell {
	
    UGUserProfileViewController* profile = [[UGUserProfileViewController alloc] init];
    [profile setUsername: [[cell storyCard] author]];
    
    [UIView beginAnimations:@"animation" context:nil];
	[self.navigationController pushViewController:profile animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
    
	[self hideVisibleBackView:YES];
}
@end

