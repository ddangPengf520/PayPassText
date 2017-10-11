//
//  PayPassTextField.m
//  AliPayPassDemo
//
//  Created by 风外杏林香 on 2017/10/11.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "PayPassTextField.h"

@implementation PayPassTextField
//禁止粘贴复制全选等
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
