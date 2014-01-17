//
//  AKDailyViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//我的日报
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
#import "AKDailyReportViewController.h"
@interface AKDailyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,currentRefreshDelegate,DailyReportDelegate>
{
    UITableView *aTableView;
    AKUploadMum *mum;
    AKCurrentRequest *currentRequestContent;
    AKUserData *userData;
    NSMutableArray *cellViewArray;
    NSMutableArray *cellArray;
    NSMutableString *pagecountStr;
    NSMutableString *currentPageStr;
    NSMutableDictionary *parameterDic;//参数Dic
    UIView *queryView;
    UITextField *queryTextField1;
    UITextField *queryTextField2;
    UITextField *queryTextField3;
    UITextField *queryTextField4;
}

@end
