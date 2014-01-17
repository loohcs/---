//
//  AKMainInterfaceViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKMainInterfaceViewController.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKFastImageView.h"
#import "AKUploadMum.h"
#import "AKCompanyNoticeContentViewController.h"
#import "AKBusinessSurveyContentViewController.h"
#import "AKBusinessTaskContentViewController.h"
#import "AKIndividualPlanViewController.h"
#import "AKDailyViewController.h"
#import "AKAlterPasswordViewController.h"
#import "AKLeaderInterfaceViewController.h"
#import "AKPhotographUploadingReportViewController.h"
@interface AKMainInterfaceViewController ()

@end

@implementation AKMainInterfaceViewController

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
    self.navigationController.navigationBarHidden = NO;
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"医药通手机端" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    UIImageView *backgroundImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-64) andImage:[UIImage imageNamed:@"bj.png"]];
    [self.view addSubview:backgroundImageView];
    NSArray *labelArray = [NSArray arrayWithObjects:@"商务任务",@"拍照回传",@"商务调查",@"个人计划",@"日报上报",@"领导专属",@"公司公告",@"修改密码",@"公司公告",@"修改密码", nil];
    for (int n=0; n<8; n++) {
        int i = n/3;
        int j = n%3;
        NSString *imageStr = [NSString stringWithFormat:@"m%d.png",n+1];
        UIImage *butImage = [UIImage imageNamed:imageStr];
        CGRect butRect = CGRectMake(20+108*j, 15+99*i, 64, 64);
        CGRect labelRect = CGRectMake(10+108*j, 80+99*i, 84, 20);
        UIButton *menuButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:butRect andNormalImage:butImage andTouchUpTarget:self andTouchUpAction:@selector(menuDetails:) andTag:100+n];
        NSString *labelName = [NSString stringWithFormat:@"%@",[labelArray objectAtIndex:n]];
        UILabel *menuLabel = [AKFastLabel labelWithFrame:labelRect andText:labelName andtextAlignment:UITextAlignmentCenter andFont:14];
        [menuLabel setTextColor:[UIColor whiteColor]];
        [self.view addSubview:menuLabel];
        [self.view addSubview:menuButton];
    }
    locationManager = [[CLLocationManager alloc] init];
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无法获取当前位置"
                                                       message:@"请在“设置”->“隐私”->“定位服务”里开启定位服务并允许本应用定位！"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
        alert.tag = 602;
        [alert show];
        [alert release];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;//指定需要精度级别
    locationManager.distanceFilter = kCLDistanceFilterNone;//设置距离筛选器
    [locationManager startUpdatingLocation];
    AKUploadMum *locationMum = [AKUploadMum locationUploadMumWithSite:CGPointMake(40, CGRectGetHeight(myScreen)-114) andMumName:@"正在获取当前位置..." andMumTag:1001];
    [self.view addSubview:locationMum];
    //    [self performSelector:@selector(removeLocationMum) withObject:nil afterDelay:1.5f];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc
{
    [locationManager release];
    [super dealloc];
}
#pragma -执行方法
//- (void)removeLocationMum
//{
//    [[self.view viewWithTag:1001] removeFromSuperview];
//}
- (void)clickLeftBtn//返回 更换账户
{
    UIAlertView *alertUser = [[UIAlertView alloc]initWithTitle:nil message:@"确定要重新登陆吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alertUser.tag = 601;
    [alertUser show];
    [alertUser release];
}
-(void)menuDetails:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:{
            AKBusinessTaskContentViewController *businessTaskContentVC = [[AKBusinessTaskContentViewController alloc]init];
            [self.navigationController pushViewController:businessTaskContentVC animated:NO];
            [businessTaskContentVC release];
            break;}
        case 101:{
            AKPhotographUploadingReportViewController *photographUploadingReportVC = [[AKPhotographUploadingReportViewController alloc]init];
            [self.navigationController pushViewController:photographUploadingReportVC animated:NO];
            [photographUploadingReportVC release];
            break;}
        case 102:{
            AKBusinessSurveyContentViewController *businessSurveyContentVC = [[AKBusinessSurveyContentViewController alloc]init];
            [self.navigationController pushViewController:businessSurveyContentVC animated:NO];
            [businessSurveyContentVC release];
            break;}
        case 103:{
            AKIndividualPlanViewController *individualPlanVC = [[AKIndividualPlanViewController alloc]init];
            [self.navigationController pushViewController:individualPlanVC animated:NO];
            [individualPlanVC release];
            break;}
        case 104:{
            AKDailyViewController *dailyVC = [[AKDailyViewController alloc]init];
            [self.navigationController pushViewController:dailyVC animated:NO];
            [dailyVC release];
            break;}
        case 105:{
            AKLeaderInterfaceViewController *leaderInterfaceVC = [[AKLeaderInterfaceViewController alloc]init];
            [self.navigationController pushViewController:leaderInterfaceVC animated:NO];
            [leaderInterfaceVC release];
            break;}
        case 106:{
            AKCompanyNoticeContentViewController *companyNoticeContentVC = [[AKCompanyNoticeContentViewController alloc]init];
            [self.navigationController pushViewController:companyNoticeContentVC animated:NO];
            [companyNoticeContentVC release];
            break;}
        case 107:{
            AKAlterPasswordViewController *alterPasswordVC = [[AKAlterPasswordViewController alloc]init];
            [self.navigationController pushViewController:alterPasswordVC animated:NO];
            [alterPasswordVC release];
            break;}
            
        default:
            break;
    }
}
#pragma - 代理方法
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 1:
            if (alertView.tag==601) {
                [self.navigationController popViewControllerAnimated:NO];
            }
            
            break;
        case 0:
            if (alertView.tag==602) {
                if ([self.view viewWithTag:1001]) {
                    [[self.view viewWithTag:1001] removeFromSuperview];
                }
//                [locationManager stopUpdatingLocation];
            }
            break;
            
        default:
            break;
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: newLocation completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            CLPlacemark *placemark = [array objectAtIndex:0];
            //            NSString *country = placemark.ISOcountryCode;
            //            NSString *city = placemark.locality;
            //            NSString *nameStr = placemark.name;
            if (!userData.userLocation||![userData.userLocation isEqualToString:placemark.name]) {
                if ([self.view viewWithTag:1001]) {
                    [[self.view viewWithTag:1001] removeFromSuperview];
                }
                userData.userLocation = placemark.name;
            }
        }
    }];
    [geocoder release];
}
@end
