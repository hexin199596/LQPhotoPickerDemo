//
//  LQImgPickerActionSheet.h
//  QQImagePicker
//
//  Created by lawchat on 15/9/23.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MHeadImaView.h"
#import "MImaLibTool.h"
#import "MShowAllGroup.h"

typedef enum {
    
    selectSend = 1,
    selectCancel = 2,
    selectCamera = 3,
    selectPhotoLib = 4
}menuSelectedType;

typedef void (^menuSelectBlock)(id obj,menuSelectedType type);

@protocol LQImgPickerActionSheetDelegate<NSObject>
@optional
//相册完成选择得到的图片
- (void)getSelectImgWithALAssetArray:(NSArray*)ALAssetArray thumbnailImgImageArray:(NSArray*)thumbnailImgArray;

@end

@interface LQImgPickerActionSheet : NSObject<UIImagePickerControllerDelegate,UIActionSheetDelegate,MShowAllGroupDelegate>
{

    UIImagePickerController *imaPic;

    UIViewController *viewController;
    
}
@property(nonatomic,assign) id<LQImgPickerActionSheetDelegate> delegate;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *arrTitles;
@property (nonatomic, copy) menuSelectBlock menuBlock;
@property (nonatomic, strong) NSArray *arrGroup;

@property (nonatomic, strong) NSMutableArray *arrSelected;

@property(nonatomic,assign)NSInteger maxCount;
- (void)showImgPickerActionSheetInView:(UIViewController*)controller;

@end
