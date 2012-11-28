//
//  UGStoryCardManager.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryCardManager.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import <AFNetworking/AFNetworking.h>
#import "UGStoryTimeRestClient.h"
#import "UGLoginManager.h"
#import "UGStoryCardItem.h"

@implementation UGStoryCardManager

-(id) init
{
    self = [super init];
    if (self) {
        cards = [[NSMutableArray alloc] init];
    }
    
    return self;
}


-(NSArray*) cards
{
    return cards;
}

-(void) empty
{
    [cards removeAllObjects];
}


-(void) requestCards
{
    NSString *path = @"/story_cards.json";
    if ([self rootCard])
        path = [NSString stringWithFormat:@"/story_cards/%@/replies.json", [[self rootCard] cardID]];
    
    NSLog(@"This is the token %@", [[UGLoginManager sharedInstance] token]);
    
    [[UGStoryTimeRestClient sharedClient] getAPIFor:path withParams:@{} withHTTPMethodType:@"get" withSuccessBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"story_cards"]) {
            [self parseJSON:responseObject];
            
            self.viewControllerDelegate.navigationItem.rightBarButtonItem.enabled = YES;
            [[[self viewControllerDelegate] tableView] reloadData];
            [SVProgressHUD dismiss];
            NSLog(@"This is how many cards there are %d", [cards count]);
        } else {
            [SVProgressHUD showErrorWithStatus:@"Incorrect username or password"];
        }
    }];
}

-(void) parseJSON: (id) json
{
    NSArray* storyCardsArray = [json objectForKey:@"story_cards"];
    for (id storyCardElement in storyCardsArray) {
        UGStoryCardItem *sc = [[UGStoryCardItem alloc] initWithJSON:storyCardElement];
        NSLog(@"Added card with content: %@", [sc content]);
        [cards addObject:sc];
    }
    
    NSLog(@"The count of cards right after adding: %d", [cards count]);
}

@end
