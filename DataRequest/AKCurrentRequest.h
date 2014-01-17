//
//  AKCurrentRequest.h
//  鲁花
//
//  Created by 凯_SKK on 13-1-21.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@protocol currentRefreshDelegate <NSObject>
@optional
-(void)refreshSucceedWithContentArray:(NSArray*)aContentArray;
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic;
-(void)refreshFailWithParameter;
-(void)refreshFailWithInternet;
@end
@interface AKCurrentRequest : NSObject<ASIHTTPRequestDelegate>
@property (assign, nonatomic)id<currentRefreshDelegate> delegate;
@property (retain, nonatomic) ASIFormDataRequest *aRequest;
-(void)currentRequestWithURL:(NSString*)aURL andParameter:(NSDictionary*)aParameter;
@end
