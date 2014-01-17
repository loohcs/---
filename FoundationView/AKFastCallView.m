//
//  AKFastCallView.m
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKFastCallView.h"
#import "AKFastLabel.h"
#import "AKFastImageView.h"
#import "AKFastView.h"
#import "AKFastImageView.h"
#import "AKFastButton.h"
#define _CELL_FONT_ 13  //字体大小
#define _MIN_CELL_FONT_ 11  //字体大小
#define _START_INTERVAL_ 5 //开头的间隔
#define _START2_INTERVAL_ 170 //开头的间隔
#define _LINE_HEIGHT_ 14 //每行的高度
#define _LINE2_HEIGHT_ 18 //每行的高度
#define _COMMON_CONTENT_WIDTH_ 150 //普通宽度
#define _ONE_WIDTH_ 20
#define _TWO_WIDTH_ 40
#define _THREE_WIDTH_ 55
#define _FOUR_WIDTH_ 65
#define _FIVE_WIDTH_ 80
#define _SIX_WIDTH_ 95
#define _SEVEN_WIDTH_ 110
#define _EIGHT_WIDTH_ 125
@implementation AKFastCallView
+(NSMutableArray*)companyNoticeCellViewWithArray:(NSArray*)aArray//公司公告
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"title"]];
        NSString *str2 = [NSString stringWithFormat:@"发布时间：%@",[aDic objectForKey:@"createtime"]];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, 315-_START_INTERVAL_, 17) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_+3];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 28, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_-1];
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel2.frame.origin.y+_LINE_HEIGHT_+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel2.frame.origin.y+_LINE_HEIGHT_+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
}
+(NSMutableArray*)businessSurveyCellViewWithArray:(NSArray*)aArray//商务调查
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"药店编号：%@",[aDic objectForKey:@"mno"]];
        NSString *str2 = [NSString stringWithFormat:@"药店名称：%@",[aDic objectForKey:@"mname"]];
        NSString *str3 = [NSString stringWithFormat:@"联系人：%@    联系手机：%@",[aDic objectForKey:@"linkman"],[aDic objectForKey:@"mobile"]];
        NSString *str4 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"address"]];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *label4 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+3*_LINE2_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"药店地址：" andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel4 = [AKFastLabel cellLabelWithFrame:CGRectMake( _START_INTERVAL_+_FOUR_WIDTH_, 5+3*_LINE2_HEIGHT_, 315-_START_INTERVAL_-_FOUR_WIDTH_, 0) andText:str4 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:0];
        CGFloat label5Float;
        if (_LINE_HEIGHT_>=contentLabel4.frame.size.height) {
            label5Float = _LINE_HEIGHT_;
        }else{
            label5Float = contentLabel4.frame.size.height;
        }
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel4.frame.origin.y+label5Float+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel4.frame.origin.y+label5Float+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:label4];
        [cellView addSubview:contentLabel4];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
}
+(NSMutableArray*)customerChoiceCellViewWithArray:(NSArray*)aArray//客户选择
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"药店编号：%@",[aDic objectForKey:@"MNo"]];
        NSString *str2 = [NSString stringWithFormat:@"药店名称：%@",[aDic objectForKey:@"MName"]];
        NSString *str3 = [NSString stringWithFormat:@"联系人：%@    联系手机：%@",[aDic objectForKey:@"LinkMan"],[aDic objectForKey:@"Mobile"]];
        NSString *str4 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"Address"]];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *label4 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+3*_LINE2_HEIGHT_, _FOUR_WIDTH_, _LINE_HEIGHT_) andText:@"药店地址：" andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel4 = [AKFastLabel cellLabelWithFrame:CGRectMake( _START_INTERVAL_+_FOUR_WIDTH_, 5+3*_LINE2_HEIGHT_, 315-_START_INTERVAL_-_FOUR_WIDTH_, 0) andText:str4 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:0];
        CGFloat label5Float;
        if (_LINE_HEIGHT_>=contentLabel4.frame.size.height) {
            label5Float = _LINE_HEIGHT_;
        }else{
            label5Float = contentLabel4.frame.size.height;
        }
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel4.frame.origin.y+label5Float+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel4.frame.origin.y+label5Float+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:label4];
        [cellView addSubview:contentLabel4];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
}
+(NSMutableArray*)businessTaskCellViewWithArray:(NSArray*)aArray andSharingTouchUpTarget:(id)aTarget andPhotoAction:(SEL)photoAction andDetailsAction:(SEL)detailsAction andFeedbackAction:(SEL)feedbackAction andPhoneAction:(SEL)phoneAction//商务任务
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    int i = 100;
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"任务发布月：%@~%@",[aDic objectForKey:@"year"],[aDic objectForKey:@"month"]];
        NSString *str2 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"mno"]];
        NSString *str3 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"mname"]];
        NSString *str4 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"linkman"]];
        NSString *str4_1 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"mobile"]];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, 180-_START_INTERVAL_, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UIButton *button1 = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(190, 4, 31, 17) andNormalImage:[UIImage imageNamed:@"photo.png"] andTouchUpTarget:aTarget andTouchUpAction:photoAction andTag:i];
        UIButton *button2 = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(235, 4, 31, 17) andNormalImage:[UIImage imageNamed:@"detail.png"] andTouchUpTarget:aTarget andTouchUpAction:detailsAction andTag:i];
        UIButton *button3 = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(280, 4, 31, 17) andNormalImage:[UIImage imageNamed:@"fankui.png"] andTouchUpTarget:aTarget andTouchUpAction:feedbackAction andTag:i];
        
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel4 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+3*_LINE2_HEIGHT_, 120-_START_INTERVAL_, _LINE_HEIGHT_) andText:str4 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel4_1 = [AKFastLabel labelWithFrame:CGRectMake(130, 5+3*_LINE2_HEIGHT_, 140, _LINE_HEIGHT_) andText:str4_1 andtextAlignment:UITextAlignmentRight andFont:_CELL_FONT_];
        UIButton *button4 = [AKFastButton buttonWithType:UIButtonTypeCustom andFrame:CGRectMake(280, 3+3*_LINE2_HEIGHT_, 30, 17) andNormalImage:[UIImage imageNamed:@"phone.png"] andTouchUpTarget:aTarget andTouchUpAction:phoneAction andTag:i];
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel4.frame.origin.y+_LINE_HEIGHT_+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel4.frame.origin.y+_LINE_HEIGHT_+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:button1];
        [cellView addSubview:button2];
        [cellView addSubview:button3];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:contentLabel4];
        [cellView addSubview:contentLabel4_1];
        [cellView addSubview:button4];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
        i++;
    }
    return [cellArray autorelease];
}
+(NSMutableArray*)individualPlanCellViewWithArray:(NSArray*)aArray//个人计划
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"[%@] %@ ",[aDic objectForKey:@"Employ"],[aDic objectForKey:@"Title"]];
        NSString *str1_1 = [NSString stringWithFormat:@"[%@]",[aDic objectForKey:@"Rnum"]];
        NSString *str2 = [NSString stringWithFormat:@"提交时间：%@",[aDic objectForKey:@"Createtime"]];
        NSString *str3 = [NSString stringWithFormat:@"计划时间：%@~%@",[aDic objectForKey:@"Stime"],[aDic objectForKey:@"Etime"]];
        UILabel *contentLabel1 = [AKFastLabel cellLabelWithFrame:CGRectMake(_START_INTERVAL_, 5, 0, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:1];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_-2];
        UILabel *contentLabel3 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_-2];
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel3.frame.origin.y+_LINE_HEIGHT_+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel3.frame.origin.y+_LINE_HEIGHT_+7) andBackgroundColor:[UIColor clearColor]];
        if (![str1_1 isEqualToString:@"[]"]) {
            UILabel *contentLabel1_1 = [AKFastLabel cellLabelWithFrame:CGRectMake(_START_INTERVAL_+contentLabel1.frame.size.width, 5, 0, _LINE_HEIGHT_) andText:str1_1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:1];
            contentLabel1_1.textColor = [UIColor redColor];
            [cellView addSubview:contentLabel1_1];
        }
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];

}
+(NSMutableArray*)dailyCellViewWithArray:(NSArray*)aArray//我的日报
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"[%@] %@ ",[aDic objectForKey:@"Employ"],[aDic objectForKey:@"Title"]];
        NSString *str1_1 = [NSString stringWithFormat:@"[%@]",[aDic objectForKey:@"Rnum"]];
        NSString *str2 = [NSString stringWithFormat:@"上报时间：%@",[aDic objectForKey:@"Createtime"]];
        UILabel *contentLabel1 = [AKFastLabel cellLabelWithFrame:CGRectMake(_START_INTERVAL_, 5, 0, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:1];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_-2];
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel2.frame.origin.y+_LINE_HEIGHT_+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel2.frame.origin.y+_LINE_HEIGHT_+7) andBackgroundColor:[UIColor clearColor]];
        if (![str1_1 isEqualToString:@"[]"]) {
            UILabel *contentLabel1_1 = [AKFastLabel cellLabelWithFrame:CGRectMake(_START_INTERVAL_+contentLabel1.frame.size.width, 5, 0, _LINE_HEIGHT_) andText:str1_1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:1];
            contentLabel1_1.textColor = [UIColor redColor];
            [cellView addSubview:contentLabel1_1];
        }
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
    
}
+(NSMutableArray*)planDetailsCellViewWithArray:(NSArray*)aArray//计划详情-批复
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"RUserName"]];
        NSString *str2 = [NSString stringWithFormat:@"批复时间：%@",[aDic objectForKey:@"Rtime"]];
        NSString *str3 = [NSString stringWithFormat:@"批复内容：%@",[aDic objectForKey:@"RContent"]];
        UILabel *label1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, _THREE_WIDTH_, _LINE_HEIGHT_) andText:@"批复人：" andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_+_THREE_WIDTH_, 5, 315-_START_INTERVAL_-_THREE_WIDTH_, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andTextColor:[UIColor redColor] andBackgroundColor:[UIColor clearColor]];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel3 = [AKFastLabel cellLabelWithFrame:CGRectMake( _START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, 0) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:0];
        CGFloat label4Float;
        if (_LINE_HEIGHT_>=contentLabel3.frame.size.height) {
            label4Float = _LINE_HEIGHT_;
        }else{
            label4Float = contentLabel3.frame.size.height;
        }
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel3.frame.origin.y+label4Float+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel3.frame.origin.y+label4Float+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:label1];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
}
+(NSMutableArray*)dailyDetailsCellViewWithArray:(NSArray*)aArray//日报详情-批复
{
    NSMutableArray *cellArray = [[NSMutableArray alloc]init];
    for (NSDictionary *aDic in aArray) {
        NSString *str1 = [NSString stringWithFormat:@"%@",[aDic objectForKey:@"RUserName"]];
        NSString *str2 = [NSString stringWithFormat:@"批复时间：%@",[aDic objectForKey:@"Rtime"]];
        NSString *str3 = [NSString stringWithFormat:@"批复内容：%@",[aDic objectForKey:@"RContent"]];
        UILabel *label1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5, _THREE_WIDTH_, _LINE_HEIGHT_) andText:@"批复人：" andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel1 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_+_THREE_WIDTH_, 5, 315-_START_INTERVAL_-_THREE_WIDTH_, _LINE_HEIGHT_) andText:str1 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andTextColor:[UIColor redColor] andBackgroundColor:[UIColor clearColor]];
        UILabel *contentLabel2 = [AKFastLabel labelWithFrame:CGRectMake(_START_INTERVAL_, 5+_LINE2_HEIGHT_, 315-_START_INTERVAL_, _LINE_HEIGHT_) andText:str2 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_];
        UILabel *contentLabel3 = [AKFastLabel cellLabelWithFrame:CGRectMake( _START_INTERVAL_, 5+2*_LINE2_HEIGHT_, 315-_START_INTERVAL_, 0) andText:str3 andtextAlignment:UITextAlignmentLeft andFont:_CELL_FONT_ andLines:0];
        CGFloat label4Float;
        if (_LINE_HEIGHT_>=contentLabel3.frame.size.height) {
            label4Float = _LINE_HEIGHT_;
        }else{
            label4Float = contentLabel3.frame.size.height;
        }
        UIImageView *boundaryImageView = [AKFastImageView imageViewWithFrame:CGRectMake(0, contentLabel3.frame.origin.y+label4Float+5, 320, 2) andImage:[UIImage imageNamed:@"divider.png"]];
        UIView *cellView = [AKFastView viewWithWithFrame:CGRectMake(0, 0, 320, contentLabel3.frame.origin.y+label4Float+7) andBackgroundColor:[UIColor clearColor]];
        [cellView addSubview:label1];
        [cellView addSubview:contentLabel1];
        [cellView addSubview:contentLabel2];
        [cellView addSubview:contentLabel3];
        [cellView addSubview:boundaryImageView];
        [cellArray addObject:cellView];
    }
    return [cellArray autorelease];
}
@end
