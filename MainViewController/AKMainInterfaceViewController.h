//
//  AKMainInterfaceViewController.h
//  医药通
//
//  Created by 凯_SKK on 13-3-27.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AKUserData.h"
@interface AKMainInterfaceViewController : UIViewController<CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;//创建一个位置管理器
    AKUserData *userData;
}

@end
