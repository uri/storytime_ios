//
//  UGStoryCardItem.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryCardItem.h"

@implementation UGStoryCardItem


-(id) initWithJSON:(id) json
{
    self = [super init];
    if (self) {
        if ([json objectForKey:@"story_card"]) {
            id sc = [json objectForKey:@"story_card"];
            _cardID = [sc objectForKey:@"id"];
            _parentCardId = [sc objectForKey:@"parent_id"];
            _content = [sc objectForKey:@"content"];
            _author = [sc objectForKey:@"author_name"];
            _numReplies = [sc objectForKey:@"total_replies"];
            _upvotes = [sc objectForKey:@"upvotes"];
            _downvotes = [sc objectForKey:@"downvotes"];
        }
    }
    return self;
}
@end
