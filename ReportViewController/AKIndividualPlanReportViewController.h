//
//  AKIndividualPlanReportViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-4-6.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//计划上报
#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKUserData.h"
#import "AKUploadMum.h"
@protocol IndividualPlanReportDelegate <NSObject>
@optional

-(void)individualPlanReportSucceedPopWillRefresh;
@end
@interface AKIndividualPlanReportViewController : UIViewController<currentRefreshDelegate,UITextFieldDelegate,UITextViewDelegate>
{
    AKUserData *userData;
    NSMutableDictionary *reportParameterDic;
    AKCurrentRequest *currentRequest;
    AKUploadMum *mum;
    BOOL isBeginTime;
}
@property (retain, nonatomic) IBOutlet UITextField *textField1;
@property (retain, nonatomic) IBOutlet UITextField *textField2;
@property (retain, nonatomic) IBOutlet UITextField *textField3;
@property (retain, nonatomic) IBOutlet UITextView *textView1;
@property (retain, nonatomic) IBOutlet UIView *dateView;
@property (retain, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (assign, nonatomic) id<IndividualPlanReportDelegate> delegate;
@end
