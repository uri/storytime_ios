//
//  UGLoginManager.m
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import "UGLoginManager.h"
#import <AFNetworking/AFNetworking.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UGStoryTimeRestClient.h"

@implementation UGLoginManager

#pragma mark -
#pragma mark init

+(id) sharedInstance
{
    static UGLoginManager *_sharedInstance;
    if (!_sharedInstance) {
        _sharedInstance = [[super allocWithZone:nil] init];
    }
    return _sharedInstance;
}

+(id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

-(id) init
{
    self = [super init];
    if (self) {
//        client = [[AFHTTPClient alloc] initWithBaseURL: [NSURL URLWithString:WEBSITE ]];
        client = [[UGStoryTimeRestClient sharedClient] client];
    }
    return self;
}

#pragma mark -
#pragma mark login api
-(void) loginAPI:(NSString*) name withPassword:(NSString*) password
{
    [[UGStoryTimeRestClient sharedClient] getAPIFor:@"/sessions.json" withParams:@{ @"name" : name, @"password" : password} withHTTPMethodType:@"post" withSuccessBlock:^(id responseObject) {
        if ([responseObject objectForKey:@"user"]) {
            [self setUsername:name];
            [self setToken: [[responseObject objectForKey:@"user"] objectForKey:@"token"]];
            [[UGStoryTimeRestClient sharedClient] setToken: [[responseObject objectForKey:@"user"] objectForKey:@"token"]];
            [_viewControllerDelegate proceed];
        } else {
            [SVProgressHUD showErrorWithStatus:@"Incorrect username or password"];
        }

    }];
}

-(void) createAccountAPI:(NSString*) name withPassword:(NSString*) password andPasswordConfirmation:(NSString*) passwordConfirmation
{
    [SVProgressHUD showWithStatus:@"Creating account..."];
    [client registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [client postPath:@"/users.json"
          parameters: @{ @"user" : @{@"name" : name, @"password" : password, @"password_confirmation" : passwordConfirmation}}
             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                 [SVProgressHUD dismiss];
                 if ([responseObject objectForKey:@"user"]) {
                     [self setUsername:name];
                     [self setToken: [[responseObject objectForKey:@"user"] objectForKey:@"token"]];
                 } else {
                     [SVProgressHUD showErrorWithStatus:@"Incorrect username or password"];
                 }
                 
             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                 [SVProgressHUD showErrorWithStatus:@"Could not connect to host."];
             }];
}


@end
