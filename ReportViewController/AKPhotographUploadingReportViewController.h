//
//  AKPhotographUploadingReportViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKParameterCurrentRequest.h"
#import "AKUserData.h"
#import "AKUploadMum.h"
#import "AKObtainImage.h"
#import "AKCustomerChoiceViewController.h"
@interface AKPhotographUploadingReportViewController : UIViewController<currentRefreshDelegate,parameterCurrentRefreshDelegate,UITextFieldDelegate,UITextViewDelegate,ObtainImageDelegate,CustomerChoiceDelegate,UITableViewDataSource,UITableViewDelegate>
{
    AKUserData *userData;
    NSMutableDictionary *reportParameterDic;
    NSMutableArray *cellArray;
    AKCurrentRequest *currentRequest;
    AKParameterCurrentRequest *parameterCurrentRequest;
    AKUploadMum *mum;
    AKObtainImage *obtainImage;
    NSInteger buttonInt;
}
@property (retain, nonatomic) IBOutlet UILabel *locationLabel;
@property (retain, nonatomic) IBOutlet UITextField *textField1;
@property (retain, nonatomic) IBOutlet UITextField *textField2;
@property (retain, nonatomic) IBOutlet UITextField *textField3;
@property (retain, nonatomic) IBOutlet UITextView *textView1;
@property (retain, nonatomic) IBOutlet UIButton *button1;
@property (retain, nonatomic) IBOutlet UIButton *button2;
@property (retain, nonatomic) IBOutlet UITableView *aTableView;
@property (retain, nonatomic) IBOutlet UIView *superTableView;

@end
