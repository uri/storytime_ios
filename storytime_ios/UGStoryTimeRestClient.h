//
//  UGStoryTimeRestClient.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPClient;

@interface UGStoryTimeRestClient : NSObject
{
    AFHTTPClient *client;
}

@property (nonatomic, strong) NSString* token;

+(UGStoryTimeRestClient*) sharedClient;

-(AFHTTPClient*) client;
-(void) getAPIFor:(NSString*) path
                 withParams:(NSDictionary*) params
         withHTTPMethodType:(NSString*) method
           withSuccessBlock: (void (^) (id))block;
@end
