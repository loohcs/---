//
//  AKApprovePlanDetailsViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-4-8.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//领导--员工计划详情--批复
#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKParameterCurrentRequest.h"
#import "AKUserData.h"
#import "AKUploadMum.h"
@interface AKApprovePlanDetailsViewController : UIViewController<currentRefreshDelegate,UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,parameterCurrentRefreshDelegate>
{
    AKUserData *userData;
    AKCurrentRequest *currentRequest;
    AKParameterCurrentRequest *parameterCurrentRequest;
    AKUploadMum *mum;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UITextView *textView1;
    UITextView *approveTextView;
    UITableView *aTableView;
    NSMutableArray *cellViewArray;
    UIView *approveView;
}
@property (retain, nonatomic) NSString *detailsId;

@end
