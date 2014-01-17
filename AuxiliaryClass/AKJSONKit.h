//
//  AKJSONKit.h
//  MobileNetwork_v1
//
//  Created by Ibokan on 12-11-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

@interface AKJSONKit : NSObject

/*
 @-method        obtainParseFromData:andEncoding:
 @-abstract      依据给定的数据和编码方式进行json解码
 @-discussion
 @-param         aData        传入的数据
                 aEncoding    数据的编码格式
 @-result        生成字典或字典数组
 */
+ (id)obtainParseFromData:(NSData *)aData andEncoding:(NSStringEncoding)aEncoding ;
@end
