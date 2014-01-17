//
//  AKIndividualPlanReportViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-4-6.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKIndividualPlanReportViewController.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKInternetInterface.h"
//判断是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AKIndividualPlanReportViewController ()

@end

@implementation AKIndividualPlanReportViewController
@synthesize delegate;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    userData = [AKUserData sharedUserData];
    reportParameterDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"add",@"action",@"",@"title",@"",@"content",@"",@"stime",@"",@"etime", nil];
    currentRequest = [[AKCurrentRequest alloc]init];
    currentRequest.delegate = self;
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"计划上报" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"上报" andBackgroundImage:[UIImage imageNamed:@"top_anniu.png"] andTouchUpTarget:self andTouchUpAction:@selector(reportRightBtn)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightButton]autorelease];
    self.textView1.text = @"";
    self.textView1.backgroundColor = [UIColor clearColor];
    self.textView1.layer.borderWidth = 1;
    [self.textView1.layer setCornerRadius:5];
    self.textView1.layer.borderColor = [UIColor grayColor].CGColor;
    mum = [AKUploadMum uploadWhiteMumWithSite:CGPointMake(60, 80) andMunName:@"正在上传..."];
    [self.view addSubview:mum];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_textField1 release];
    [_textField2 release];
    [_textField3 release];
    [_textView1 release];
    [_dateView release];
    [_datePicker release];
    [reportParameterDic release];
    [currentRequest release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [self setTextView1:nil];
    [self setDateView:nil];
    [self setDatePicker:nil];
    [super viewDidUnload];
}
#pragma - 执行方法
-(void)reportRightBtn
{
    [self touchesBegan:nil withEvent:nil];
    if ([self.textField1.text isEqualToString:@""]
        ||[self.textField2.text isEqualToString:@""]
        ||[self.textField3.text isEqualToString:@""]
        ||[self.textView1.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"请输入完整上报内容！"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else{
        [reportParameterDic setObject:self.textField1.text forKey:@"title"];
        [reportParameterDic setObject:self.textField2.text forKey:@"stime"];
        [reportParameterDic setObject:self.textField3.text forKey:@"etime"];
        [reportParameterDic setObject:self.textView1.text forKey:@"content"];
        //        NSLog(@"%@",reportParameterDic);
        [currentRequest currentRequestWithURL:_YGJIHUA_INTERFACE_ andParameter:reportParameterDic];
        mum.hidden = NO;
    }
}
-(void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
- (IBAction)choiceSDate:(id)sender//选择开始时间
{
    [self touchesBegan:nil withEvent:nil];
    isBeginTime = YES;
    self.dateView.hidden = NO;
}
- (IBAction)choiceEDate:(id)sender//选择结束时间
{
    [self touchesBegan:nil withEvent:nil];
    isBeginTime = NO;
    self.dateView.hidden = NO;
}
- (IBAction)cancelDateMethod:(id)sender//取消选取时间
{
    self.dateView.hidden = YES;
}
- (IBAction)selectDateMethod:(id)sender//确定选取时间
{
    NSDate *selectDate = [self.datePicker date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *dateStr = [dateFormat stringFromDate:selectDate];
    NSString *selectStr = [dateStr substringToIndex:10];
    if (isBeginTime) {
        self.textField2.text = selectStr;
    }else{
        self.textField3.text = selectStr;
    }
    [dateFormat release];
    self.dateView.hidden = YES;
}
#pragma mark - refresh代理方法
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
//    NSLog(@"%@",aContentDic);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    NSString *causeStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"cause"]];
    if ([flagStr isEqualToString:@"success"]) {
        [self.navigationController popViewControllerAnimated:NO];
        [delegate individualPlanReportSucceedPopWillRefresh];
    }
    else{
        if ([causeStr isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"数据上传失败，请重新上传。"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:causeStr
                                                          delegate:nil
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];}
    }
}
//解析数据失败
-(void)refreshFailWithParameter
{
    mum.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"数据上传失败，请重新上传。"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//网络问题
-(void)refreshFailWithInternet
{
    mum.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"网络连接失败，请检查网络后再试！"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView beginAnimations:@"Animations" context:nil]; //context传值
    [UIView setAnimationDuration:0.25f];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = translation;
    [UIView commitAnimations];
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textView1 resignFirstResponder];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 401:{
            [UIView beginAnimations:@"Animations" context:nil]; //context传值
            [UIView setAnimationDuration:0.25f];
            CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
            self.view.transform = translation;
            [UIView commitAnimations];
            return YES;
            break;}
        case 402:{
            [UIView beginAnimations:@"Animations" context:nil]; //context传值
            [UIView setAnimationDuration:0.25f];
            CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
            self.view.transform = translation;
            [UIView commitAnimations];
            return NO;
            break;}
        case 403:{
            [UIView beginAnimations:@"Animations" context:nil]; //context传值
            [UIView setAnimationDuration:0.25f];
            CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
            self.view.transform = translation;
            [UIView commitAnimations];
            return NO;
            break;}
        default:
            break;
    }
    return NO;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if (!iPhone5) {
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -45);
        self.view.transform = translation;
        [UIView commitAnimations];
    }
    
}
@end
