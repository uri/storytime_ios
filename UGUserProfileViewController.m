//
//  UGUserProfileViewController.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-12-06.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGUserProfileViewController.h"
#import "UGStoryTimeRestClient.h"
#import "UGStoryCardViewController.h"

@interface UGUserProfileViewController ()

@end

@implementation UGUserProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _topStories = [[NSMutableArray alloc ] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *path = [NSString stringWithFormat:@"/users/%@.json", _username];
    [[UGStoryTimeRestClient sharedClient] getAPIFor:path withParams:@{} withHTTPMethodType:@"get" withSuccessBlock:^(id data) {
        // Somethign
        NSString* up = [[[data objectForKey:@"user"] objectForKey:@"upvotes"] stringValue];
        NSString* down = [[[data objectForKey:@"user"] objectForKey:@"downvotes"] stringValue];
        
        [_upvoteScoreLabel setText:up];
        [_downvoteScoreLabel setText:down];
        
        [_topStories removeAllObjects];
        
        for (id st in [[data objectForKey:@"user"] objectForKey:@"story_cards"]) {
            // Do stuff
            id card = [st objectForKey:@"story_card"];
            [_topStories addObject: card];
        }
        [[self recentStories] reloadData];
        [[self view] setNeedsDisplay];
    }];
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
    
    NSString* text = [[_topStories objectAtIndex: [indexPath row]] objectForKey:@"content"];
    
    [[cell textLabel] setText:text];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"The count, %d", [_topStories count]);
    return [_topStories count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UGStoryCardItem* rootCard = [[UGStoryCardItem alloc] init];
    [rootCard setCardID: [[_topStories objectAtIndex:[indexPath row]] objectForKey:@"id"]];
    UGStoryCardViewController* sc = [[UGStoryCardViewController alloc] initWithRootCard:rootCard];
    
    [UIView beginAnimations:@"animations" context:nil];
    [[self navigationController] pushViewController:sc animated:NO];
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlDown forView:self.navigationController.view cache:NO];
    [UIView commitAnimations];
}


@end
