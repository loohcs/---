//
//  AKNoticeDetailsViewController.h
//  农化通
//
//  Created by 凯_SKK on 13-3-14.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//公司公告详情 
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
@interface AKNoticeDetailsViewController : UIViewController<currentRefreshDelegate>
{
    AKUploadMum *mum;
    AKCurrentRequest *currentRequestContent;
    AKUserData *userData;
    NSMutableDictionary *parameterDic;//参数Dic
}
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UITextView *textView1;
@property (retain, nonatomic) NSString *noticeId;
@end
