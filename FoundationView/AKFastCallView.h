//
//  AKFastCallView.h
//  医药通
//
//  Created by 凯_SKK on 13-3-28.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AKFastCallView : NSObject
+(NSMutableArray*)companyNoticeCellViewWithArray:(NSArray*)aArray;//公司公告
+(NSMutableArray*)customerChoiceCellViewWithArray:(NSArray*)aArray;//药店选择
+(NSMutableArray*)businessSurveyCellViewWithArray:(NSArray*)aArray;//商务调查
+(NSMutableArray*)businessTaskCellViewWithArray:(NSArray*)aArray andSharingTouchUpTarget:(id)aTarget andPhotoAction:(SEL)photoAction andDetailsAction:(SEL)detailsAction andFeedbackAction:(SEL)feedbackAction andPhoneAction:(SEL)phoneAction;//商务任务
+(NSMutableArray*)individualPlanCellViewWithArray:(NSArray*)aArray;//个人计划
+(NSMutableArray*)dailyCellViewWithArray:(NSArray*)aArray;//我的日报
+(NSMutableArray*)planDetailsCellViewWithArray:(NSArray*)aArray;//计划详情-批复
+(NSMutableArray*)dailyDetailsCellViewWithArray:(NSArray*)aArray;//日报详情-批复
@end
