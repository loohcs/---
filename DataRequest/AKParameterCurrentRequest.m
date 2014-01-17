//
//  AKParameterCurrentRequest.m
//  医药通
//
//  Created by 凯_SKK on 13-3-29.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKParameterCurrentRequest.h"
#import "AKJSONKit.h"
@implementation AKParameterCurrentRequest
@synthesize delegate;
@synthesize aRequest;
-(void)dealloc
{
    if (nil!=self.aRequest) {
        [self.aRequest clearDelegatesAndCancel];
        [aRequest release];
    }
    [super dealloc];
}
-(void)parameterCurrentRequestWithURL:(NSString*)aURL andParameter:(NSDictionary*)aParameter
{
    NSString *urlStr = [NSString stringWithFormat:@"%@",aURL];
    NSURL *url = [NSURL URLWithString:urlStr];
    if (nil!=self.aRequest) {
        [self.aRequest clearDelegatesAndCancel];
    }
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    NSArray *keyArray = [NSArray arrayWithArray:[aParameter allKeys]];
    for (int i=0; i<keyArray.count; i++){
        NSString *keyStr = [NSString stringWithFormat:@"%@",[keyArray objectAtIndex:i]];
        NSString *valueStr = [NSString stringWithFormat:@"%@",[aParameter objectForKey:keyStr]];
        [request setPostValue:valueStr forKey:keyStr];
    }
    [request setDidFailSelector:@selector(requestDidFailed:)];
    [request setDidFinishSelector:@selector(requestDidSuccess:)];
    self.aRequest = request;
    [request startAsynchronous];
}
#pragma mark - 代理方法
//执行成功
- (void)requestDidSuccess:(ASIFormDataRequest *)request

{
    NSData *data = [request responseData];
    NSDictionary *oneDic = [AKJSONKit obtainParseFromData:data andEncoding:NSUTF8StringEncoding];
    if (oneDic) {
        [self.delegate parameterRefreshSucceedWithContentDictionary:oneDic];
        
    }else{
        [self.delegate parameterRefreshFailWithParameter];
    }
}
//执行失败
- (void)requestDidFailed:(ASIFormDataRequest *)request
{
    [self.delegate parameterRefreshFailWithInternet];
}
@end
