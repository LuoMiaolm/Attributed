//
//  ViewController.m
//  TextModel
//
//  Created by luomiao on 2017/5/4.
//  Copyright © 2017年 LM. All rights reserved.
//

#import "ViewController.h"
#import "TextView.h"

#define Str1 @"整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。整段文字，没有回车。"
#define Str2 @"1、第一段。第一段。第一段。第一段。第一段。第一段。第一段。第一段。第一段。第一段。\n2、第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。第二段。\n3、第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。第三段。"
#define Str3 @"\n与上面段落字体不一样。与上面段落字体不一样。\n与上面段落字体不一样。与上面段落字体不一样。"


@interface ViewController ()
{
    UILabel *_label;
}

@property (nonatomic, strong) TextView *textView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self demo1];
    
    [self demo2];
    
}

// 文字适应label
- (void)demo1
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(20, 70, 80, 40);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"大" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pressBtnBig) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(140, 70, 80, 40);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"小" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pressBtnSmall) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(120, 150, 150, 30)];
    _label.layer.borderColor = [UIColor blackColor].CGColor;
    _label.layer.borderWidth = 0.5;
    _label.text = @"根据label大小自适应";
    _label.textAlignment = NSTextAlignmentCenter;
    // 设置文字自适应
    _label.adjustsFontSizeToFitWidth = YES;
    // UIBaselineAdjustmentAlignBaselines 居下
    // UIBaselineAdjustmentAlignCenters 居中
    // UIBaselineAdjustmentNone 居上
    _label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [self.view addSubview:_label];
}

- (void)pressBtnBig
{
    _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y, 150, 30);
}

- (void)pressBtnSmall
{
    _label.frame = CGRectMake(_label.frame.origin.x, _label.frame.origin.y, 100, 30);
}

// label适应文字
- (void)demo2
{
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn1.frame = CGRectMake(20, 250, 80, 40);
    btn1.backgroundColor = [UIColor orangeColor];
    [btn1 setTitle:@"无分段" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(pressBtn1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(140, 250, 80, 40);
    btn2.backgroundColor = [UIColor orangeColor];
    [btn2 setTitle:@"分段" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(pressBtn2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(260, 250, 80, 40);
    btn3.backgroundColor = [UIColor orangeColor];
    [btn3 setTitle:@"分段且不同" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(pressBtn3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    __weak typeof(self) weakSelf = self;;
    _textView = [[TextView alloc] initWithFrame:CGRectMake(10, 320, [UIScreen mainScreen].bounds.size.width - 20, 200)];
    _textView.backgroundColor = [UIColor brownColor];
    [self.view addSubview:_textView];
    
    [_textView setHeightBlock:^(CGFloat height) {
        CGRect oriFrame = weakSelf.textView.frame;
        weakSelf.textView.frame = CGRectMake(oriFrame.origin.x, oriFrame.origin.y, oriFrame.size.width, height);
    }];
}

// 不分段文字
- (void)pressBtn1
{
    [_textView updateText:Str1];
}

// 分段落文字
- (void)pressBtn2
{
    [_textView updateParagraph:Str2];
}

// 分段落，且段落文字样式不一样
- (void)pressBtn3
{
    [_textView updateAttText:Str2 dText:Str3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
