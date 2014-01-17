//
//  AKUserData.m
//  农化通
//
//  Created by 凯_SKK on 13-3-4.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKUserData.h"

@implementation AKUserData
@synthesize userId = _userId;
@synthesize userAccount = _userAccount;
@synthesize userPassword = _userPassword;
@synthesize userIsLeader = _userIsLeader;
@synthesize userLocation = _userLocation;
static AKUserData *userData = nil;
-(void)dealloc
{
    [_userId release];
    [_userAccount release];
    [_userPassword release];
    [_userIsLeader release];
    [_userLocation release];
    [super dealloc];
}
+(AKUserData*)sharedUserData
{
    @synchronized(userData){
        if (userData==nil) {
            userData = [[AKUserData alloc]init];
        }
    }
    return userData;
}
@end
