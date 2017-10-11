//
//  PayPassView.m
//  AliPayPassDemo
//
//  Created by 风外杏林香 on 2017/10/11.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "PayPassView.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ColorRGB(r,g,b,a)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define allLineColor       [UIColor colorWithRed:205/255.0 green:205/255.0 blue:205/255.0 alpha:1]
#define SASize CGSizeMake (10, 10) //密码点的大小

@interface PayPassView ()<UITextFieldDelegate>
@property (nonatomic, strong)UIView *backGroundView;
@property (nonatomic, strong)NSMutableArray *dataArray;// 用来存放黑色小点

@end

@implementation PayPassView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initWithUI];
    }
    return self;
}

- (void)initWithUI
{
    self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.backGroundView.backgroundColor = [UIColor blackColor];
    self.backGroundView.alpha = 0.5;
    self.backGroundView.userInteractionEnabled = YES;
    [self addSubview:self.backGroundView];
    
    UIView *view1 = [[UIView alloc]init];
    if (ScreenWidth != 320) {
        view1.frame = CGRectMake(0, ScreenHeight / 2, ScreenWidth, ScreenHeight / 2);
    } else {
        view1.frame = CGRectMake(0, ScreenHeight / 2 - 50, ScreenWidth, ScreenHeight / 2 + 50);
    }
    view1.backgroundColor = [UIColor whiteColor];
    [self addSubview:view1];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, ScreenWidth, 30)];
    label1.textColor = ColorRGB(51, 51, 51, 1);
    label1.backgroundColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15.f];
    label1.text = NSLocalizedString(@"请输入支付密码",);
    [view1 addSubview:label1];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame = CGRectMake(ScreenWidth - 40, 0, 40, 40);
    button.titleLabel.font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    [button setImage:[UIImage imageNamed:@"cha_Image"] forState:(UIControlStateNormal)];
    [button setTitleColor:ColorRGB(153, 153, 153, 1) forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [view1 addSubview:button];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label1.frame) + 5, ScreenWidth, 0.5)];
    lineView.backgroundColor = allLineColor;
    [view1 addSubview:lineView];
    
    self.passText = [[PayPassTextField alloc]initWithFrame:CGRectMake(20, CGRectGetMaxY(lineView.frame) + 10, ScreenWidth - 40, 40)];
    self.passText.keyboardType = UIKeyboardTypeNumberPad;
    self.passText.backgroundColor = [UIColor whiteColor];
    //输入的文字颜色为白色
    self.passText.textColor = [UIColor whiteColor];
    //输入框光标的颜色为白色
    self.passText.tintColor = [UIColor whiteColor];
    self.passText.delegate = self;
    self.passText.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.passText.layer.borderColor = allLineColor.CGColor;
    self.passText.layer.borderWidth = 0.5;
    [self.passText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [view1 addSubview:self.passText];
    
    CGFloat width = CGRectGetWidth(self.passText.frame) / 6;
    
    //生成分割线
    for (int i = 0; i < 5; i ++) {
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passText.frame) + (i + 1) * (width + 0.5), CGRectGetMinY(self.passText.frame), 0.5, 40)];
        lineView.backgroundColor = allLineColor;
        [view1 addSubview:lineView];
    }
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 6; i++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.passText.frame) + (width - 6) / 2 + i * width, CGRectGetMinY(self.passText.frame) + (40 - SASize.height) / 2, SASize.width, SASize.height)];
        dotView.backgroundColor = [UIColor blackColor];
        dotView.layer.cornerRadius = SASize.width / 2.0f;
        dotView.clipsToBounds = YES;
        dotView.hidden = YES; //先隐藏
        [view1 addSubview:dotView];
        //把创建的黑色点加入到数组中
        [self.dataArray addObject:dotView];
    }
}

#pragma mark -- UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([string isEqualToString:@"\n"]) {
        //按回车关闭键盘
        [textField resignFirstResponder];
        return NO;
    } else if(string.length == 0) {
        //判断是不是删除键
        return YES;
    } else if(textField.text.length >= 6) {
        //输入的字符个数大于6，则无法继续输入，返回NO表示禁止输入
        NSLog(@"输入的字符个数大于6，忽略输入");
        return NO;
    } else {
        return YES;
    }
    
}

- (void)textFieldDidChange:(UITextField *)textField
{
    for (UIView *dotView in self.dataArray) {
        dotView.hidden = YES;
    }
    for (int i = 0; i < textField.text.length; i ++) {
        ((UIView *)[self.dataArray objectAtIndex:i]).hidden = NO;
    }
    if (textField.text.length == 6) {
        _finishInput(textField.text);
        [self removeFromSuperview];
    }
}

- (void)buttonAction:(UIButton *)sender
{
    [self removeFromSuperview];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
