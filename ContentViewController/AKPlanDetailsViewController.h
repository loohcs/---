//
//  AKPlanDetailsViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-4-7.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//我的计划详情
#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKUserData.h"
#import "AKUploadMum.h"
@interface AKPlanDetailsViewController : UIViewController<currentRefreshDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AKUserData *userData;
    AKCurrentRequest *currentRequest;
    AKUploadMum *mum;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UILabel *label4;
    UITextView *textView1;
    UITableView *aTableView;
    NSMutableArray *cellViewArray;
}
@property (retain, nonatomic) NSString *detailsId;
@end
