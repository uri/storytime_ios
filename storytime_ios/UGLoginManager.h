//
//  UGLoginManager.h
//  storytime_ios
//
//  Created by Uri Gorelik on 12-11-26.
//  Copyright (c) 2012 Health Wave. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UGLoginViewController.h"

@class AFHTTPClient;

@interface UGLoginManager : NSObject
{
    AFHTTPClient *client;
}

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) UGLoginViewController *viewControllerDelegate;

+(id) sharedInstance;

-(void) loginAPI:(NSString*) name withPassword:(NSString*) password;
-(void) createAccountAPI:(NSString*) name withPassword:(NSString*) password andPasswordConfirmation:(NSString*) passwordConfirmation;


@end
