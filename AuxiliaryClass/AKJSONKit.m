//
//  AKJSONKit.m
//  MobileNetwork_v1
//
//  Created by Ibokan on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AKJSONKit.h"
#import "JSONKit.h"
@interface AKJSONKit ()
/*
 @-method        obtainDictionaryFromString:andEncoding:
 @-abstract      依据给定的Joson字符串和编码方式进行json解码
 @-discussion
 @-param         aString      传入的字符串
 @-result        生成字典
 */
+ (NSDictionary *)obtainDictionaryFromString:(NSMutableString *)aString;

/*
 @-method        obtainArrayFromString:andEncoding:
 @-abstract      依据给定的Joson字符串和编码方式进行json解码
 @-discussion
 @-param         aString      传入的字符串
 @-result        生成字典数组
 */
+ (NSArray *)obtainArrayFromString:(NSMutableString *)aString;
@end
@implementation AKJSONKit
+ (id)obtainParseFromData:(NSData *)aData andEncoding:(NSStringEncoding)aEncoding
{
    NSMutableString *jsonStr = [[NSMutableString alloc] initWithData:aData encoding:aEncoding];
    NSMutableString *aJsonStr = [[NSMutableString alloc] initWithString:jsonStr];
    NSDictionary *dict = [AKJSONKit obtainDictionaryFromString:jsonStr];
    [jsonStr release];
    NSArray *arr = [AKJSONKit obtainArrayFromString:aJsonStr];
    [aJsonStr release];
    if (dict) {
        return dict;
    }
    return arr;
}
+ (NSDictionary *)obtainDictionaryFromString:(NSMutableString *)aString
{
    NSRange range = [aString rangeOfString:@"{"];
    NSRange delRange;
    delRange.location = 0;
    if (range.length == 0) {
        delRange.length = 0;
    }
    else
    {
        delRange.length = range.location;
    }
    [aString deleteCharactersInRange:delRange];
    return [aString mutableObjectFromJSONString];
}
+ (NSArray *)obtainArrayFromString:(NSMutableString *)aString
{
    NSRange range = [aString rangeOfString:@"["];
    NSRange delRange;
    delRange.location = 0;
    if (range.length == 0) {
        delRange.length = 0;
    }
    else
    {
        delRange.length = range.location;
    }
    [aString deleteCharactersInRange:delRange];
    return [aString mutableObjectFromJSONString];
}
@end
