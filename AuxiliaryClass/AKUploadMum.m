//
//  AKUploadMum.m
//  鲁花
//
//  Created by 凯_SKK on 13-1-21.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKUploadMum.h"
#import "AKFastLabel.h"
@implementation AKUploadMum

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
+(AKUploadMum*)uploadMumWithSite:(CGPoint)site andMunName:(NSString*)aName
{
    AKUploadMum *maxMumView =[[AKUploadMum alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    maxMumView.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.2];
    UIView *mumView = [[UIView alloc]initWithFrame:CGRectMake(60, site.y, 200, 100)];
    mumView.layer.cornerRadius = 15.f;
    mumView.layer.masksToBounds = YES;//View变为圆角  用到layer
    mumView.backgroundColor = [UIColor blackColor];
    mumView.alpha = 0.9;
    UIActivityIndicatorView *refreshMum = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    refreshMum.frame = CGRectMake(80, 20, 40, 40);
    [refreshMum startAnimating];
    [mumView addSubview:refreshMum];
    [refreshMum release];
    UILabel *mumLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 60, 200, 30) andText:aName andtextAlignment:UITextAlignmentCenter andFont:15.f andTextColor:[UIColor whiteColor] andBackgroundColor:[UIColor clearColor]];
    [mumView addSubview:mumLabel];
    [maxMumView addSubview:mumView];
    [mumView release];
    maxMumView.hidden = YES;
    return [maxMumView autorelease];
    
}
+(AKUploadMum*)uploadWhiteMumWithSite:(CGPoint)site andMunName:(NSString*)aName
{
    AKUploadMum *mumView = [[AKUploadMum alloc]initWithFrame:CGRectMake(60, site.y, 200, 100)];
    mumView.layer.cornerRadius = 15.f;
    mumView.layer.masksToBounds = YES;//View变为圆角  用到layer
    mumView.backgroundColor = [UIColor clearColor];
    mumView.alpha = 0.9;
    mumView.hidden = YES;
    UIActivityIndicatorView *refreshMum = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    refreshMum.frame = CGRectMake(80, 20, 40, 40);
    refreshMum.color = [UIColor blackColor];
    [refreshMum startAnimating];
    [mumView addSubview:refreshMum];
    [refreshMum release];
    UILabel *mumLabel = [AKFastLabel labelWithFrame:CGRectMake(0, 50, 200, 30) andText:aName andtextAlignment:UITextAlignmentCenter andFont:15.f andTextColor:[UIColor blackColor] andBackgroundColor:[UIColor clearColor]];
    [mumView addSubview:mumLabel];
    return [mumView autorelease];
}
+(AKUploadMum*)locationUploadMumWithSite:(CGPoint)site andMumName:(NSString*)aName andMumTag:(NSInteger)aTag
{
    AKUploadMum *mumView = [[AKUploadMum alloc]initWithFrame:CGRectMake(40, site.y, 240, 30)];
    [mumView setBackgroundColor:[UIColor blackColor]];
//    mumView.hidden = YES;
    mumView.tag = aTag;
    UIActivityIndicatorView *refreshMum = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    refreshMum.frame = CGRectMake(10, 0, 30, 30);
    [refreshMum startAnimating];
    [mumView addSubview:refreshMum];
    [refreshMum release];
    UILabel *mumLabel = [AKFastLabel labelWithFrame:CGRectMake(55, 0, 165, 30) andText:aName andtextAlignment:UITextAlignmentLeft andFont:17.f andTextColor:[UIColor whiteColor] andBackgroundColor:[UIColor clearColor]];
    [mumView addSubview:mumLabel];
    return [mumView autorelease];
}
@end
