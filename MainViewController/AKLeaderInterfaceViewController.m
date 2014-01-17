//
//  AKLeaderInterfaceViewController.m
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKLeaderInterfaceViewController.h"
#import "AKFastLabel.h"
#import "AKFastButton.h"
#import "AKFastImageView.h"
#import "AKApprovePlanContentViewController.h"
#import "AKApproveDailyContentViewController.h"
@interface AKLeaderInterfaceViewController ()

@end

@implementation AKLeaderInterfaceViewController

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
    self.navigationController.navigationBarHidden = NO;
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"领导专属" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
    CGRect myScreen=[[UIScreen mainScreen]bounds];
    UIImageView *backgroundImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, 0, CGRectGetWidth(myScreen), CGRectGetHeight(myScreen)-64) andImage:[UIImage imageNamed:@"bj.png"]];
    [self.view addSubview:backgroundImageView];
    NSArray *labelArray = [NSArray arrayWithObjects:@"员工计划",@"员工日报", nil];
    for (int n=0; n<2; n++) {
        int i = n/3;
        int j = n%3;
        NSString *imageStr = [NSString stringWithFormat:@"gz%d.png",n+1];
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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma -执行方法
- (void)clickLeftBtn//返回 更换账户
{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)menuDetails:(UIButton*)sender
{
    switch (sender.tag) {
        case 100:{
            AKApprovePlanContentViewController *approvePlanContentVC = [[AKApprovePlanContentViewController alloc]init];
            [self.navigationController pushViewController:approvePlanContentVC animated:NO];
            [approvePlanContentVC release];
            break;}
        case 101:{
            AKApproveDailyContentViewController *approveDailyContentVC = [[AKApproveDailyContentViewController alloc]init];
            [self.navigationController pushViewController:approveDailyContentVC animated:NO];
            [approveDailyContentVC release];
            break;}
            
        default:
            break;
    }
}
@end
