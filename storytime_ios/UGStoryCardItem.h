//
//  UGStoryCardItem.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UGStoryCardItem : NSObject

@property (nonatomic, strong) NSNumber* cardID;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSNumber* upvotes;
@property (nonatomic, strong) NSNumber* downvotes;
@property (nonatomic, strong) NSNumber* numReplies;
@property (nonatomic, strong) NSNumber* parentCardId;

-(id) initWithJSON:(id) json;
@end
