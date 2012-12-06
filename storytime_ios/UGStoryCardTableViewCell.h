//
//  UGStoryCardTableViewCell.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGStoryCardItem.h"
#import "TISwipeableTableView.h"
@class UGStoryCardTableViewCell;

@protocol UGStoryCardTableViewCellDelegate <NSObject>

-(void) cellUpvoteWasTapped:(UGStoryCardTableViewCell*) cell;
-(void) cellDownvoteWasTapped:(UGStoryCardTableViewCell*) cell;

@end

@interface UGStoryCardTableViewCell : TISwipeableTableViewCell
{
}

@property (nonatomic, strong) UGStoryCardItem *storyCard;
@property (nonatomic, strong) id <UGStoryCardTableViewCellDelegate> delegate;
@property (nonatomic, copy) NSString * text;

+ (CGFloat)heightForCellWithStoryCard:(UGStoryCardItem *)sc;
- (void)drawShadowsWithHeight:(CGFloat)shadowHeight opacity:(CGFloat)opacity InRect:(CGRect)rect forContext:(CGContextRef)context;
@end
