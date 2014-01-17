//
//  AKImageContentViewController.m
//  农化通
//
//  Created by 凯_SKK on 13-3-12.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKImageContentViewController.h"
#import "AKFastButton.h"
#import "AKFastLabel.h"
#import "AKFastImageView.h"
@interface AKImageContentViewController ()

@end

@implementation AKImageContentViewController
@synthesize aImage = _aImage;
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
    UILabel *topItemLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 0, 180, 30) andText:@"图片预览" andtextAlignment:UITextAlignmentCenter andFont:18];
    self.navigationItem.titleView = topItemLabel;
    UIButton *leftButton = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(0, 0, 40, 27) andNormalImage:[UIImage imageNamed:@"top_fh_left.png"] andTouchUpTarget:self andTouchUpAction:@selector(clickLeftBtn)];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:14];
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc]initWithCustomView:leftButton]autorelease];
	UIImageView *image = [AKFastImageView imageViewWithFrame:CGRectMake(0, 0, 320, 416) andImage:_aImage];
    [self.view addSubview:image];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    [_aImage release];
    [super dealloc];
}
-(void)clickLeftBtn
{
    [self.navigationController popViewControllerAnimated:NO];
}
@end
