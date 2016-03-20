//
//  LQImgPickerActionSheet.m
//  QQImagePicker
//
//  Created by lawchat on 15/9/23.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "LQImgPickerActionSheet.h"

@implementation LQImgPickerActionSheet

- (instancetype)init
{
    self = [super init];
    if (self) {
        if (!_arrSelected) {
            self.arrSelected = [NSMutableArray array];
        }
    }
    return self;
}

#pragma mark - 显示选择照片提示sheet
- (void)showImgPickerActionSheetInView:(UIViewController*)controller{
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:@"拍照", @"相册中选择",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    viewController = controller;
    [actionSheet showInView:viewController.view];
    
}
#pragma mark - 加载照片数据
- (void)loadImgDataAndShowAllGroup{
    if (!_arrSelected) {
        self.arrSelected = [NSMutableArray array];
    }
    [[MImaLibTool shareMImaLibTool] getAllGroupWithArrObj:^(NSArray *arrObj) {
        if (arrObj && arrObj.count > 0) {
            self.arrGroup = arrObj;
            if ( self.arrGroup.count > 0) {
                MShowAllGroup *svc = [[MShowAllGroup alloc] initWithArrGroup:self.arrGroup arrSelected:self.arrSelected];
                svc.delegate = self;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
                if (_arrSelected) {
                    svc.arrSeleted = _arrSelected;
                    svc.mvc.arrSelected = _arrSelected;
                }
                svc.maxCout = _maxCount;
                [viewController presentViewController:nav animated:YES completion:nil];
            }
        }
    }];
}

#pragma mark - 选择（“拍照”，“相册选择”）
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (!imaPic) {
            imaPic = [[UIImagePickerController alloc] init];
        }
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imaPic.sourceType = UIImagePickerControllerSourceTypeCamera;
            imaPic.delegate = self;
            [viewController presentViewController:imaPic animated:NO completion:nil];
        }
    }else if (buttonIndex == 1) {

        [self loadImgDataAndShowAllGroup];
    }
}

#pragma mark - 相机拍照得到的UIImage
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *theImage = nil;
    // 判断，图片是否允许修改
    if ([picker allowsEditing]){
        //获取用户编辑之后的图像
        theImage = [info objectForKey:UIImagePickerControllerEditedImage];
    } else {
        // 照片的元数据参数
        theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        
    }
    if (theImage) {
        // 保存图片到相册中
        MImaLibTool *imgLibTool = [MImaLibTool shareMImaLibTool];
        [imgLibTool.lib writeImageToSavedPhotosAlbum:[theImage CGImage] orientation:(ALAssetOrientation)[theImage imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
            } else {
                
                //获取图片路径
                [imgLibTool.lib assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                    if (asset) {
                        
                        [_arrSelected addObject:asset];
                        [self finishSelectImg];
                        [picker dismissViewControllerAnimated:NO completion:nil];
                    }
                } failureBlock:^(NSError *error) {
                    
                }];
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:NO completion:nil];
}

#pragma mark - 完成选择后返回的图片Array(ALAsset*)
- (void)finishSelectImg{
    //正方形缩略图
    NSMutableArray *thumbnailImgArr = [NSMutableArray array];
    
    for (ALAsset *set in _arrSelected) {
        CGImageRef cgImg = [set thumbnail];
        UIImage* image = [UIImage imageWithCGImage: cgImg];
        [thumbnailImgArr addObject:image];
    }

    [self.delegate  getSelectImgWithALAssetArray:_arrSelected thumbnailImgImageArray:thumbnailImgArr];
}

@end
