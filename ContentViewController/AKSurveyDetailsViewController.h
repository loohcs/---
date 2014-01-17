//
//  AKSurveyDetailsViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-4-1.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//调查详情
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
@interface AKSurveyDetailsViewController : UIViewController<currentRefreshDelegate>
{
    AKUploadMum *mum;
    AKCurrentRequest *currentRequestContent;
    AKUserData *userData;
    NSMutableDictionary *parameterDic;//参数Dic
}
@property (retain, nonatomic) IBOutlet UILabel *label2;
@property (retain, nonatomic) IBOutlet UILabel *label1;
@property (retain, nonatomic) IBOutlet UILabel *label3;
@property (retain, nonatomic) IBOutlet UILabel *label4;
@property (retain, nonatomic) IBOutlet UILabel *label5;
@property (retain, nonatomic) IBOutlet UILabel *label6;
@property (retain, nonatomic) IBOutlet UILabel *label7;
@property (retain, nonatomic) IBOutlet UILabel *label8;
@property (retain, nonatomic) IBOutlet UILabel *label9;
@property (retain, nonatomic) IBOutlet UILabel *label10;
@property (retain, nonatomic) IBOutlet UILabel *label11;
@property (retain, nonatomic) IBOutlet UILabel *label12;
@property (retain, nonatomic) IBOutlet UILabel *label13;
@property (retain, nonatomic) IBOutlet UILabel *label14;
@property (retain, nonatomic) IBOutlet UILabel *label15;
@property (retain, nonatomic) IBOutlet UILabel *label16;
@property (retain, nonatomic) IBOutlet UILabel *label17;
@property (retain, nonatomic) IBOutlet UILabel *label18;
@property (retain, nonatomic) IBOutlet UILabel *label19;
@property (retain, nonatomic) IBOutlet UILabel *label20;
@property (retain, nonatomic) IBOutlet UILabel *label21;
@property (retain, nonatomic) IBOutlet UILabel *label22;
@property (retain, nonatomic) IBOutlet UIScrollView *aScrollView;
@property (retain, nonatomic) NSString *surveyId;
@property (retain, nonatomic) NSString *surveyURL;
@end
