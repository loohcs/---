//
//  AKIndividualPlanViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
// 
//个人计划
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
#import "AKIndividualPlanReportViewController.h"
@interface AKIndividualPlanViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,currentRefreshDelegate,IndividualPlanReportDelegate>
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
