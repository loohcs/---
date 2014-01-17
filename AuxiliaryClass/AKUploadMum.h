//
//  AKUploadMum.h
//  鲁花
//
//  Created by 凯_SKK on 13-1-21.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface AKUploadMum : UIView
+(AKUploadMum*)uploadMumWithSite:(CGPoint)site andMunName:(NSString*)aName;
+(AKUploadMum*)uploadWhiteMumWithSite:(CGPoint)site andMunName:(NSString*)aName;
+(AKUploadMum*)locationUploadMumWithSite:(CGPoint)site andMumName:(NSString*)aName andMumTag:(NSInteger)aTag;
@end
