//
//  UGStoryCardManager.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UGStoryCardViewController.h"

@class UGStoryCardItem;

@interface UGStoryCardManager : NSObject
{
    NSMutableArray *cards;
}

@property (nonatomic, strong) UGStoryCardItem *rootCard;
@property (nonatomic, strong) UGStoryCardViewController *viewControllerDelegate;


-(NSArray*) cards;
-(void) empty;
-(void) requestCards;

@end
