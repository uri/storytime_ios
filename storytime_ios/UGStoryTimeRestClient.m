//
//  UGStoryTimeRestClient.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-27.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGStoryTimeRestClient.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UGLoginManager.h"

@implementation UGStoryTimeRestClient

+(UGStoryTimeRestClient*) sharedClient
{
    static UGStoryTimeRestClient *_sharedClient = nil;
    if (!_sharedClient) {
        _sharedClient = [[super allocWithZone:nil] init];
    }
    return _sharedClient;
}

+(id) allocWithZone:(NSZone *)zone
{
    return [self sharedClient];
}

-(id) init
{
    self = [super init];
    if (self) {
        client = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:WEBSITE ]];
    }
    return self;
}


-(AFHTTPClient*) client
{
    return client;
}

-(void)           getAPIFor:(NSString*) path
                 withParams:(NSDictionary*) params
         withHTTPMethodType:(NSString*) method
           withSuccessBlock: (void (^) (id responseObject))block
{
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
    
    if (_token)
        [body addEntriesFromDictionary:@{ @"token" : _token}];
    [body addEntriesFromDictionary:params];
    
    [SVProgressHUD showWithStatus:@"..."];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    if ([[method lowercaseString] isEqualToString:@"get"]) {
        [client getPath:path
             parameters: body
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [SVProgressHUD dismiss];
                    block(responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"Could not connect to host."];
                }];
        
    } else if ([method isEqualToString:@"post"]) {
        [client postPath:path
             parameters: body
                success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    [SVProgressHUD dismiss];
                    NSLog(@"%@", responseObject);
                    block(responseObject);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    [SVProgressHUD showErrorWithStatus:@"Could not connect to host."];
                }];
        
    }
    
}
@end
