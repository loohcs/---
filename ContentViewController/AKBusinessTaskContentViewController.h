//
//  AKBusinessTaskContentViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//商务任务
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
#import "AKParameterCurrentRequest.h"
@interface AKBusinessTaskContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,currentRefreshDelegate,parameterCurrentRefreshDelegate>
{
    UITableView *aTableView;
    AKUploadMum *mum;
    AKCurrentRequest *currentRequestContent;
    AKParameterCurrentRequest *parameterCurrentRequest;
    AKUserData *userData;
    NSMutableArray *cellViewArray;
    NSMutableArray *cellArray;
    NSMutableString *pagecountStr;
    NSMutableString *currentPageStr;
    NSMutableDictionary *parameterDic;//参数Dic
    UIView *queryView;
    UIView *feedbackView;
    UITextField *queryTextField1;
    UITextField *queryTextField2;
    UITextField *queryTextField3;
    UITextField *queryTextField4;
    UITextField *queryTextField5;
    UITextField *queryTextField6;
    UIButton *isFeedbackBtn;
    UIButton *noFeedbackBtn;
    UITextView *feedbackTextView;
    NSInteger feedbackIndex;
}


@end
