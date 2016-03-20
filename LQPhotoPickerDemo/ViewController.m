//
//  ViewController.m
//  LQPhotoPickerDemo
//
//  Created by 李庆 on 16/3/20.
//  Copyright © 2016年 李庆. All rights reserved.
//

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height//获取设备高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width//获取设备宽度

#import "ViewController.h"

@interface ViewController ()
{
    
    //备注文本View高度
    float noteTextHeight;
    
    float pickerViewHeight;
    float allViewHeight;

}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //收起键盘
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    self.showInView = _scrollView;
    
    [self initPickerView];
    
    [self initViews];
}

- (void)viewTapped{
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"caseLogNeedRef" object:nil];
}

- (void)initViews{
    
    _noteTextBackgroudView = [[UIView alloc]init];
    _noteTextBackgroudView.backgroundColor = [UIColor colorWithWhite:1 alpha:1];
    
    _noteTextView = [[UITextView alloc]init];
    _noteTextView.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _noteTextView.delegate = self;
    _noteTextView.font = [UIFont boldSystemFontOfSize:14];
    
    _textNumberLabel = [[UILabel alloc]init];
    _textNumberLabel.textAlignment = NSTextAlignmentRight;
    _textNumberLabel.font = [UIFont boldSystemFontOfSize:12];
    _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    _textNumberLabel.backgroundColor = [UIColor whiteColor];
    _textNumberLabel.text = @"0/300    ";
    
    _explainLabel = [[UILabel alloc]init];
    _explainLabel.text = @"添加图片不超过10张，文字备注不超过300字";
    _explainLabel.textColor = [UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:199.0/255.0 alpha:1.0];
    _explainLabel.textAlignment = NSTextAlignmentCenter;
    _explainLabel.font = [UIFont boldSystemFontOfSize:12];
    
    _submitBtn = [[UIButton alloc]init];
    [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [_submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_submitBtn setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:155.0/255.0 blue:0.0/255.0 alpha:1.0]];
    [_submitBtn addTarget:self action:@selector(submitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_noteTextBackgroudView];
    [_scrollView addSubview:_noteTextView];
    [_scrollView addSubview:_textNumberLabel];
    [_scrollView addSubview:_explainLabel];
    [_scrollView addSubview:_submitBtn];
    
    [self updateViewsFrame];
}
- (void)updateViewsFrame{
    
    if (!allViewHeight) {
        allViewHeight = 0;
    }
    if (!noteTextHeight) {
        noteTextHeight = 100;
    }
    
    _noteTextBackgroudView.frame = CGRectMake(0, 0, SCREENWIDTH, noteTextHeight);
    
    //文本编辑框
    _noteTextView.frame = CGRectMake(15, 0, SCREENWIDTH - 30, noteTextHeight);
    
    
    //文字个数提示Label
    _textNumberLabel.frame = CGRectMake(0, _noteTextView.frame.origin.y + _noteTextView.frame.size.height-15, SCREENWIDTH-10, 15);
    
    
    //photoPicker
    [self updatePickerViewFrameY:_textNumberLabel.frame.origin.y + _textNumberLabel.frame.size.height];
    
    
    //说明文字
    _explainLabel.frame = CGRectMake(0, [self getPickerViewFrame].origin.y+[self getPickerViewFrame].size.height+10, SCREENWIDTH, 20);
    
    
    //提交按钮
    _submitBtn.bounds = CGRectMake(10, _explainLabel.frame.origin.y+_explainLabel.frame.size.height +30, SCREENWIDTH -20, 40);
    _submitBtn.frame = CGRectMake(10, _explainLabel.frame.origin.y+_explainLabel.frame.size.height +30, SCREENWIDTH -20, 40);
    
    
    allViewHeight = noteTextHeight + [self getPickerViewFrame].size.height + 30 + 100;
    
    _scrollView.contentSize = self.scrollView.contentSize = CGSizeMake(0,allViewHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)pickerViewFrameChanged{
    [self updateViewsFrame];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/300    ",(unsigned long)_noteTextView.text.length];
    if (_noteTextView.text.length > 300) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    
    [self textChanged];
    return YES;
}

- (void)textViewDidChangeSelection:(UITextView *)textView{
    _textNumberLabel.text = [NSString stringWithFormat:@"%lu/300    ",(unsigned long)_noteTextView.text.length];
    if (_noteTextView.text.length > 300) {
        _textNumberLabel.textColor = [UIColor redColor];
    }
    else{
        _textNumberLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
    }
    [self textChanged];
}

-(void)textChanged{
    
    CGRect orgRect = self.noteTextView.frame;//获取原始UITextView的frame
    
    CGSize size = [self.noteTextView sizeThatFits:CGSizeMake(self.noteTextView.frame.size.width, MAXFLOAT)];
    
    orgRect.size.height=size.height+10;//获取自适应文本内容高度
    
    if (orgRect.size.height > 100) {
        noteTextHeight = orgRect.size.height;
    }
    [self updateViewsFrame];
}

- (void)submitBtnClicked{
    
    if (![self checkInput]) {
        return;
    }
    [self submitToServer];
}

#pragma maek - 检查输入
- (BOOL)checkInput{
    if (_noteTextView.text.length == 0) {
        //MBhudText(self.view, @"请添加记录备注", 1);
        return NO;
    }
    return YES;
}


#pragma mark - 上传数据到服务器前将图片转data（上传服务器用form表单：未写）
- (void)submitToServer{
    //大图数据
    NSArray *bigImageDataArray = [self getBigImageArray];
    
    //小图数组
    NSArray *smallImageArray = self.imageArray;
    
    //小图数据
    NSMutableArray *smallImageDataArray = [NSMutableArray array];
    for (UIImage *smallImg in smallImageArray) {
        NSData *smallImgData = UIImagePNGRepresentation(smallImg);
        [smallImageDataArray addObject:smallImgData];
    }
    
}



@end

