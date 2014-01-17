//
//  AKLogInViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKCurrentRequest.h"
#import "AKUploadMum.h"
@interface AKLogInViewController : UIViewController<UITextFieldDelegate,currentRefreshDelegate>
{
    AKUploadMum *mum;//加载菊花
    AKCurrentRequest *logInRequest;
}
@property (retain, nonatomic) IBOutlet UITextField *textField1;
@property (retain, nonatomic) IBOutlet UITextField *textField2;
@property (retain, nonatomic) IBOutlet UITextField *textField3;
@property (retain, nonatomic) IBOutlet UIButton *rememberBut;

@end
