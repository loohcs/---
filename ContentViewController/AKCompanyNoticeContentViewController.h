//
//  AKCompanyNoticeContentViewController.h
//  农化通
//
//  Created by 凯_SKK on 13-3-4.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//公司公告
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
@interface AKCompanyNoticeContentViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,currentRefreshDelegate>
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
}

@end
