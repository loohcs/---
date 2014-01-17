//
//  AKObtainImage.h
//  ASI_test
//
//  Created by 凯_SKK on 13-2-4.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ObtainImageDelegate <NSObject>
@optional

-(void)obtainImageSucceedWithImage:(UIImage*)aImage;
@end
@interface AKObtainImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImagePickerController *imagePickerController;
    UIViewController *viewController;
}
@property (assign, nonatomic) id<ObtainImageDelegate> delegate;
-(id)initWithViewController:(UIViewController*)aViewController;
-(void)imageSourceByPhotoLibrary;//图片来源于相册
-(void)imageSourceByCamera;//图片来源于相机
@end
