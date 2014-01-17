//
//  AKBusinessPhotoViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-4-2.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKBusinessPhotoViewController.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKFastImageView.h"
#import "AKInternetInterface.h"
#import "Photo.h"
#import "AKImageContentViewController.h"
//判断是否是iphone5
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
@interface AKBusinessPhotoViewController ()

@end

@implementation AKBusinessPhotoViewController
@synthesize mName = _mName;
@synthesize mNo = _mNo;
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
    obtainImage = [[AKObtainImage alloc]initWithViewController:self];
    obtainImage.delegate = self;
    reportParameterDic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"add",@"action",@"",@"title",@"",@"intro",@"",@"mno",@"",@"mname",@"",@"address", nil];
    currentRequest = [[AKCurrentRequest alloc]init];
    currentRequest.delegate = self;
    parameterCurrentRequest = [[AKParameterCurrentRequest alloc]init];
    parameterCurrentRequest.delegate = self;
    cellArray = [[NSMutableArray alloc]init];
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"拍照回传" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    UIButton *rightButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalTitle:@"上报" andBackgroundImage:[UIImage imageNamed:@"top_anniu"] andTouchUpTarget:self andTouchUpAction:@selector(reportRightBtn)];
    rightButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:rightButton]autorelease];
    UIImageView *buttonImageView = [AKFastImageView imageViewWithFrame:CGRectMake(146, 12, 14, 9) andImage:[UIImage imageNamed:@"main-三角.png"]];
    [self.button1 addSubview:buttonImageView];
    UIImageView *buttonImageView2 = [AKFastImageView imageViewWithFrame:CGRectMake(146, 12, 14, 9) andImage:[UIImage imageNamed:@"main-三角.png"]];
    [self.button2 addSubview:buttonImageView2];
    self.textField1.text = _mNo;
    self.textField2.text = _mName;
    self.textView1.text = @"";
    self.textView1.backgroundColor = [UIColor clearColor];
    self.textView1.layer.borderWidth = 1;
    [self.textView1.layer setCornerRadius:5];
    self.textView1.layer.borderColor = [UIColor grayColor].CGColor;
    self.locationLabel.text = userData.userLocation;
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
    [_locationLabel release];
    [_textView1 release];
    [_button1 release];
    [_button2 release];
    [_superTableView release];
    [_aTableView release];
    [reportParameterDic release];
    [currentRequest release];
    [obtainImage release];
    [parameterCurrentRequest release];
    [cellArray release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTextField1:nil];
    [self setTextField2:nil];
    [self setTextField3:nil];
    [self setLocationLabel:nil];
    [self setTextView1:nil];
    [self setButton1:nil];
    [self setButton2:nil];
    [self setSuperTableView:nil];
    [self setATableView:nil];
    [super viewDidUnload];
}
- (IBAction)takeAPicture:(id)sender//拍照
{
    [self touchesBegan:nil withEvent:nil];
    [obtainImage imageSourceByCamera];
}
- (IBAction)previewPhoto:(id)sender//预览
{
    [self touchesBegan:nil withEvent:nil];
    if ([reportParameterDic objectForKey:@"photo"]) {
        NSString *imageStr = [reportParameterDic objectForKey:@"photo"];
        UIImage *image = [Photo string2Image:imageStr];
        AKImageContentViewController *imageContentVC = [[AKImageContentViewController alloc]init];
        imageContentVC.aImage = image;
        [self.navigationController pushViewController:imageContentVC animated:NO];
        [imageContentVC release];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"没有图片，请先获取图片！"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }

}
- (IBAction)photoLeixing:(id)sender//拍照类型
{
    [self touchesBegan:nil withEvent:nil];
    UIButton *btn = (UIButton*)sender;
    buttonInt = btn.tag;
    //    http://skyeyes.ip165.com/yyt/port/config.aspx?cid=008&mobile=18953553903&pwd=123&ctype=%E9%83%A8%E9%97%A8
    NSDictionary *aDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"拍照类型",@"ctype", nil];
    [parameterCurrentRequest parameterCurrentRequestWithURL:_CANSHU_LIST_INTERFACE_ andParameter:aDic];
}
- (IBAction)photoZhonglei:(id)sender//拍照种类
{
    [self touchesBegan:nil withEvent:nil];
    UIButton *btn = (UIButton*)sender;
    buttonInt = btn.tag;
    NSDictionary *aDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"拍照种类",@"ctype", nil];
    [parameterCurrentRequest parameterCurrentRequestWithURL:_CANSHU_LIST_INTERFACE_ andParameter:aDic];
}
-(void)reportRightBtn
{
    //    http://skyeyes.ip165.com/yyt/port/photo.aspx?cid=008&mobile=18953553903&pwd=123&action=add&mno=&mname=&title=&mtype=&mclass=&intro=&photo=&point=&address=
    [self touchesBegan:nil withEvent:nil];
    if ([self.textField1.text isEqualToString:@""]
        ||[self.textField2.text isEqualToString:@""]
        ||[self.textField3.text isEqualToString:@""]||
        [reportParameterDic objectForKey:@"photo"]==nil||
        [reportParameterDic objectForKey:@"mtype"]==nil||
        [reportParameterDic objectForKey:@"mclass"]==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"请填写完整上报选项！"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }else{
        [reportParameterDic setObject:self.textField1.text forKey:@"mno"];
        [reportParameterDic setObject:self.textField2.text forKey:@"mname"];
        [reportParameterDic setObject:self.textField3.text forKey:@"title"];
        [reportParameterDic setObject:self.textView1.text forKey:@"intro"];
        if (self.locationLabel.text) {
            [reportParameterDic setObject:self.locationLabel.text forKey:@"address"];
        }
        //        NSLog(@"%@",reportParameterDic);
        [currentRequest currentRequestWithURL:_PAIZHAO_INTERFACE_ andParameter:reportParameterDic];
        mum.hidden = NO;
    }
}
-(void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
#pragma --获取图片的代理
-(void)obtainImageSucceedWithImage:(UIImage*)aImage
{
    CGSize newSize = CGSizeMake(800, 600);
    UIImage *newImage = [Photo imageCompressForSize:aImage targetSize:newSize];
    NSString *imageStr = [Photo image2String:newImage];
    [reportParameterDic setObject:imageStr forKey:@"photo"];
}
#pragma mark - refresh代理方法
//请求成功
-(void)parameterRefreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    //    NSLog(@"%@",aContentDic);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    if ([flagStr isEqualToString:@"success"]) {
        NSArray *nodeArray = [NSArray arrayWithArray:[aContentDic objectForKey:@"Config"]];
        [cellArray setArray:nil];
        for (NSDictionary *dic in nodeArray) {
            [cellArray addObject:dic];
        }
        self.superTableView.hidden = NO;
        [self.aTableView reloadData];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"数据连接失败"
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
//解析数据失败
-(void)parameterRefreshFailWithParameter
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"数据连接失败"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//网络问题
-(void)parameterRefreshFailWithInternet
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"网络连接失败，请检查网络后再试！"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:nil];
    [alert show];
    [alert release];
}
//请求成功
-(void)refreshSucceedWithContentDictionary:(NSDictionary*)aContentDic
{
    mum.hidden = YES;
    //NSLog(@"%@",aContentDic);
    NSString *flagStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"flag"]];
    NSString *causeStr = [NSString stringWithFormat:@"%@",[aContentDic objectForKey:@"cause"]];
    if ([flagStr isEqualToString:@"success"]) {
        NSDictionary *aDic = [NSDictionary dictionaryWithObjectsAndKeys:userData.userId,@"cid",userData.userAccount,@"mobile",userData.userPassword,@"pwd",@"add",@"action",@"",@"title",@"",@"intro",@"",@"mno",@"",@"mname",@"我的位置",@"address", nil];
        [reportParameterDic setDictionary:aDic];
        self.textField1.text = @"";
        self.textField2.text = @"";
        self.textField3.text = @"";
        self.textView1.text = @"";
        self.button1.titleLabel.text = @"请选择";
        self.button2.titleLabel.text = @"请选择";
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:causeStr
                                                      delegate:self
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        if ([causeStr isEqualToString:@""]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:causeStr
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                           message:@"数据上传失败"
                                                          delegate:self
                                                 cancelButtonTitle:@"确定"
                                                 otherButtonTitles:nil];
            [alert show];
            [alert release];
        }
        
    }
}
//解析数据失败
-(void)refreshFailWithParameter
{
    mum.hidden = YES;
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                   message:@"数据上传失败"
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
#pragma mark - TableView代理方法

//返回Section的个数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//返回Row的个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellArray.count;
}
//返回cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}
//绘制Cell
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    if (cellArray.count!=0) {
        
        NSDictionary *dic= [cellArray objectAtIndex:indexPath.row];
        cell.textLabel.text = [dic objectForKey:@"text"];
        [cell.textLabel setFont:[UIFont systemFontOfSize:17]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}//点击Cell触发的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[cellArray objectAtIndex:indexPath.row]];
    switch (buttonInt) {
        case 101:{
            [reportParameterDic setObject:[dic objectForKey:@"text"] forKey:@"mtype"];
            self.button1.titleLabel.text = [dic objectForKey:@"text"];
            self.superTableView.hidden = YES;
            break;}
        case 102:{
            [reportParameterDic setObject:[dic objectForKey:@"text"] forKey:@"mclass"];
            self.button2.titleLabel.text = [dic objectForKey:@"text"];
            self.superTableView.hidden = YES;
            break;}
        default:
            break;
    }
    [cellArray setArray:nil];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textView1 resignFirstResponder];
    [UIView beginAnimations:@"Animations" context:nil]; //context传值
    [UIView setAnimationDuration:0.25f];
    CGAffineTransform translation = CGAffineTransformMakeTranslation(0, 0);
    self.view.transform = translation;
    [UIView commitAnimations];
}
#pragma mark - 代理
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 401:{
            [self touchesBegan:nil withEvent:nil];
            return NO;
            break;}
        case 402:{
            [self touchesBegan:nil withEvent:nil];
            return NO;
            break;}
        case 403:
            if (!iPhone5) {
                [UIView beginAnimations:@"Animations" context:nil]; //context传值
                [UIView setAnimationDuration:0.25f];
                CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -50);
                self.view.transform = translation;
                [UIView commitAnimations];
            }
            return YES;
            break;
        default:
            return NO;
            break;
    }
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (!iPhone5) {
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -175);
        self.view.transform = translation;
        [UIView commitAnimations];
    }else{
        [UIView beginAnimations:@"Animations" context:nil]; //context传值
        [UIView setAnimationDuration:0.25f];
        CGAffineTransform translation = CGAffineTransformMakeTranslation(0, -85);
        self.view.transform = translation;
        [UIView commitAnimations];
    }
    
    return YES;
}
@end
