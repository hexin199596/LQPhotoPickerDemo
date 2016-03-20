//
//  ViewController.h
//  LQPhotoPickerDemo
//
//  Created by 李庆 on 16/3/20.
//  Copyright © 2016年 李庆. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LQPhotoPickerViewController.h"
@interface ViewController : LQPhotoPickerViewController<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong) UIView *noteTextBackgroudView;
//备注
@property(nonatomic,strong) UITextView *noteTextView;

//文字个数提示label
@property(nonatomic,strong) UILabel *textNumberLabel;

//文字说明
@property(nonatomic,strong) UILabel *explainLabel;

//提交按钮
@property(nonatomic,strong) UIButton *submitBtn;

@end

