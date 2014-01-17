//
//  AKParameterCurrentRequest.h
//  医药通
//
//  Created by 凯_SKK on 13-3-29.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@protocol parameterCurrentRefreshDelegate <NSObject>
@optional
-(void)parameterRefreshSucceedWithContentArray:(NSArray*)aContentArray;
-(void)parameterRefreshSucceedWithContentDictionary:(NSDictionary*)aContentDic;
-(void)parameterRefreshFailWithParameter;
-(void)parameterRefreshFailWithInternet;
@end
@interface AKParameterCurrentRequest : NSObject
@property(assign,nonatomic)id<parameterCurrentRefreshDelegate> delegate;
@property (retain, nonatomic) ASIFormDataRequest *aRequest;
-(void)parameterCurrentRequestWithURL:(NSString*)aURL andParameter:(NSDictionary*)aParameter;
@end
