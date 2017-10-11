//
//  PayPassView.h
//  AliPayPassDemo
//
//  Created by 风外杏林香 on 2017/10/11.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayPassTextField.h"

//输入完成、回调
typedef void (^TextFinished)(NSString *textStr);

@interface PayPassView : UIView

@property (nonatomic, strong)PayPassTextField *passText;
@property (nonatomic, copy)TextFinished finishInput;

@end
