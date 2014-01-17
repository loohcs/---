//
//  AKDatePicker.m
//  鲁花
//
//  Created by 凯_SKK on 13-1-24.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKDatePicker.h"

@implementation AKDatePicker
+(UIDatePicker*)queryDatePicker
{
    UIDatePicker *datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0,40,0,0)];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSLocale* locale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
//    [datePicker setLocale:[NSLocale currentLocale]];
    [datePicker setLocale:locale];
    [locale release];
    NSDate *newDate = [NSDate date];
    [datePicker setDate:newDate animated:NO];
    return [datePicker autorelease];
}
@end
