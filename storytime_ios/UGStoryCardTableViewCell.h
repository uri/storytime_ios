//
//  UGStoryCardTableViewCell.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UGStoryCardItem.h"

@interface UGStoryCardTableViewCell : UITableViewCell
{
}

@property (nonatomic, strong) UGStoryCardItem *storyCard;

+ (CGFloat)heightForCellWithStoryCard:(UGStoryCardItem *)sc;
@end
