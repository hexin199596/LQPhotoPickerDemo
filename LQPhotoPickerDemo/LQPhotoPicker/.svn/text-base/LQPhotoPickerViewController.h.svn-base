//
//  LQPhotoPickerViewController.h
//  LQPhotoPicker
//
//  Created by lawchat on 15/9/22.
//  Copyright (c) 2015年 Fillinse. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQPhotoViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "LQImgPickerActionSheet.h"
#import "JJPhotoManeger.h"

@protocol LQPhotoPickerViewDelegate <NSObject>

@optional



@end

@interface LQPhotoPickerViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LQImgPickerActionSheetDelegate,JJPhotoDelegate>

@property(nonatomic,assign) id<LQPhotoPickerViewDelegate> delegate;

@property(nonatomic,strong) UICollectionView *pickerCollectionView;
@property(nonatomic,assign) CGFloat collectionFrameY;

//选择的图片数据()
@property(nonatomic,strong) NSMutableArray *arrSelected;

//方形压缩图image 数组
@property(nonatomic,strong) NSMutableArray * imageArray;

//大图image 数组
@property(nonatomic,strong) NSMutableArray * bigImageArray;

@property(nonatomic,strong) NSMutableArray * bigImgDataArray;

//图片选择器
@property(nonatomic,strong) UIViewController *showActionSheetViewController;

//collectionView所在view
@property(nonatomic,strong) UIView *showInView;

//图片总数量限制
@property(nonatomic,assign) NSInteger maxCount;


//初始化collectionView
- (void)initPickerView;
//修改collectionView的位置
- (void)updatePickerViewFrameY:(CGFloat)Y;
//获得collectionView 的 Frame
- (CGRect)getPickerViewFrame;

//获取选中的所有图片信息
- (NSArray*)getSmallImageArray;
- (NSArray*)getBigImageArray;
- (NSArray*)getALAssetArray;

- (void)pickerViewFrameChanged;

@end
