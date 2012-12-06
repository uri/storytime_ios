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


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadRequest)];

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
	
	UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Button from back view"
														 message:@"You tapped the upvote button"
														delegate:nil cancelButtonTitle:@"Okay..."
											   otherButtonTitles:nil];
	[alertView show];
	
	[self hideVisibleBackView:YES];
}
@end

