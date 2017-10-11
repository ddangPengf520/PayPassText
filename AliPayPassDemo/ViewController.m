//
//  ViewController.m
//  AliPayPassDemo
//
//  Created by 风外杏林香 on 2017/10/11.
//  Copyright © 2017年 风外杏林香. All rights reserved.
//

#import "ViewController.h"
#import "PayPassView.h"

#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
@property (nonatomic, strong)PayPassView *payPassView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"9999");
    [self initWithPayPassView];
}

- (void)initWithPayPassView
{
    self.payPassView = [[PayPassView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.payPassView.passText becomeFirstResponder];
    __block ViewController *blockSelf = self;
    self.payPassView.finishInput = ^(NSString *textStr){
        NSLog(@"textStr -- %@", textStr);
    };
    [self.view addSubview:self.payPassView];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
