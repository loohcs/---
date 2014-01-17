//
//  AKObtainImage.m
//  ASI_test
//
//  Created by 凯_SKK on 13-2-4.
//  Copyright (c) 2013年 山东乐世安通通信技术有限公司. All rights reserved.
//

#import "AKObtainImage.h"

@implementation AKObtainImage
@synthesize delegate;
-(void)dealloc
{
    [imagePickerController release];
    [super dealloc];
}
-(id)initWithViewController:(UIViewController*)aViewController
{
    self = [super init];
    if (self) {
    imagePickerController = [[UIImagePickerController alloc]init];
    imagePickerController.allowsEditing = NO;
    imagePickerController.delegate = self;
    viewController = aViewController;
    }
    return self;
}
-(void)imageSourceByPhotoLibrary//图片来源于相册
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;//默认相册
        [viewController presentModalViewController:imagePickerController animated:NO];
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"无法打开相册！"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}
-(void)imageSourceByCamera//图片来源于相机
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;//相册
        [viewController presentModalViewController:imagePickerController animated:NO];//显示 图片选取器
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                       message:@"无法打开照相机！"
                                                      delegate:nil
                                             cancelButtonTitle:@"确定"
                                             otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
}
- (void)image:(UIImage *)image FinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo//拍照获取图像后的警告
{
    if (error != nil) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"获取图片失败" message:@"请检验手机“设置”->“隐私”->“照片”中是否允许本应用获取图片" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    
    
}
//选择完图片后进入的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *aImage = [info objectForKey: @"UIImagePickerControllerOriginalImage"];
    if (picker.allowsEditing == YES) {
        aImage = [info objectForKey: @"UIImagePickerControllerEditedImage"];
    }
    //判断图片的来源方式
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        UIImageWriteToSavedPhotosAlbum(aImage, self, @selector(image:FinishSavingWithError:contextInfo:), nil);
    }
    if (aImage) {
        [delegate obtainImageSucceedWithImage:aImage];
    }
    [viewController dismissModalViewControllerAnimated:NO];
}
@end
