//
//  AKUserData.h
//  农化通
//
//  Created by 凯_SKK on 13-3-4.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKUserData : NSObject
@property(retain,nonatomic)NSString *userId;
@property(retain,nonatomic)NSString *userAccount;
@property(retain,nonatomic)NSString *userPassword;
@property(retain,nonatomic)NSString *userIsLeader;
@property(retain,nonatomic)NSString *userLocation;
+(AKUserData*)sharedUserData;
@end
