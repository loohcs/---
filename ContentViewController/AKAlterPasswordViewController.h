//
//  AKAlterPasswordViewController.h
//  农化通
//
//  Created by 凯_SKK on 13-3-7.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//
//密码修改
#import <UIKit/UIKit.h>
#import "AKUploadMum.h"
#import "AKUserData.h"
#import "AKCurrentRequest.h"
@interface AKAlterPasswordViewController : UIViewController<currentRefreshDelegate>
{
    AKUploadMum *mum;
    AKCurrentRequest *currentRequestContent;
    AKUserData *userData;
}
@property (retain, nonatomic) IBOutlet UITextField *textField1;
@property (retain, nonatomic) IBOutlet UITextField *textField2;
@property (retain, nonatomic) IBOutlet UITextField *textField3;

@end
