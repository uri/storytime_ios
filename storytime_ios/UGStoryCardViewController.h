//
//  UGStoryCardViewController.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UGStoryCardManager;
@class UGStoryCardItem;

@interface UGStoryCardViewController : UITableViewController
{
    UGStoryCardManager *cardManager;
}
-(id)initWithRootCard:(UGStoryCardItem*) rCard;
-(void) reloadRequest;

@end
