//
//  AKDailyDetailsViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-4-8.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//我的日报详情
#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKUserData.h"
#import "AKUploadMum.h"
@interface AKDailyDetailsViewController : UIViewController<currentRefreshDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AKUserData *userData;
    AKCurrentRequest *currentRequest;
    AKUploadMum *mum;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    UITextView *textView1;
    UITableView *aTableView;
    NSMutableArray *cellViewArray;
}
@property (retain, nonatomic) NSString *detailsId;

@end
