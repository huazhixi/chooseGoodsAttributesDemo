//
//  XWAlterVeiw.m
//  XWAleratView
//
//  Created by 温仲斌 on 15/12/25.
//  Copyright © 2015年 温仲斌. All rights reserved.
//

#import "XWAlterView.h"
#import "ACMacros.h"

#define W CGRectGetWidth([UIScreen mainScreen].bounds)
#define H CGRectGetHeight([UIScreen mainScreen].bounds)

@interface XWTextField : UITextField

@end

@implementation XWTextField

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
//    UIBezierPath *be = [UIBezierPath bezierPath];
//    [be moveToPoint:CGPointMake(0, CGRectGetHeight(self.frame))];
//
//    [be addLineToPoint:CGPointMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//    be.lineWidth = .2;
//    [[UIColor lightGrayColor]set];
//    [be stroke];
}

@end

@interface XWAlterView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) XWTextField *text;
@property (nonatomic, strong) NSMutableString *textStr;

@end

@implementation XWAlterView

@synthesize lab,text;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5];
        
        self.bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, W - 40, 150)];
        _bigView.layer.cornerRadius = 5;
        _bigView.layer.masksToBounds = YES;
        _bigView.backgroundColor = [UIColor whiteColor];
        _bigView.center = CGPointMake(W / 2, H / 2);
        text = [[XWTextField alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_bigView.frame) - 30, 25)];
        text.center = CGPointMake(CGRectGetWidth(_bigView.frame)/2, CGRectGetHeight(_bigView.frame)/2);
        text.placeholder = @"请输入";
        text.textAlignment = NSTextAlignmentCenter;
        text.delegate = self;
        [_bigView addSubview:text];
        
        lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        lab.backgroundColor = [UIColor whiteColor];
        lab.layer.cornerRadius = 40;
        lab.textColor = [UIColor redColor];
        lab.layer.masksToBounds = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.text = @"设置店名";
        lab.center =  CGPointMake(self.center.x , self.center.y - CGRectGetHeight(_bigView.frame)/2 + 20);
        [self addSubview:_bigView];
        [self addSubview:lab];
        
        UIButton *bu1 = [UIButton buttonWithType:UIButtonTypeCustom];
        bu1.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bu1.layer.borderWidth = .3f;
        bu1.bounds = CGRectMake(0, 0, CGRectGetWidth(_bigView.frame)/ 2, 44);
        bu1.center = CGPointMake(CGRectGetWidth(_bigView.bounds)/4, CGRectGetHeight(_bigView.bounds) - 44 + 24);
        [bu1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [bu1 addTarget:self action:@selector(button1) forControlEvents:UIControlEventTouchUpInside];
        [bu1 setTitle:@"取消" forState:UIControlStateNormal];
        [_bigView addSubview:bu1];
        
        UIButton *bu2 = [UIButton buttonWithType:UIButtonTypeCustom];
        bu2.backgroundColor = kMAINCOLOR;
        bu2.layer.borderColor = [UIColor lightGrayColor].CGColor;
        bu2.layer.borderWidth = .3f;
        bu2.bounds = CGRectMake(0, 0, CGRectGetWidth(_bigView.frame)/ 2, 44);
        bu2.center = CGPointMake(3 * CGRectGetWidth(_bigView.bounds)/4, CGRectGetHeight(_bigView.bounds) - 44 + 24);
        [bu2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bu2 setTitle:@"确定" forState:UIControlStateNormal];
        [bu2 addTarget:self action:@selector(button2) forControlEvents:UIControlEventTouchUpInside];
        [_bigView addSubview:bu2];
        _textStr = [NSMutableString stringWithFormat:@"￥"];
        _bigView.transform = CGAffineTransformMakeScale(0, 0);
        lab.transform = CGAffineTransformMakeScale(0,0);
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)button2 {
    [self dissmiss];
    if (_textBlock) {
        _textBlock(text.text);
    }
}

- (void)dissmiss {
    [UIView animateWithDuration:.2 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [text resignFirstResponder];
    }];
}

- (void)button1 {
    [self dissmiss];
}

- (void)keyboardShow:(NSNotification *)no {
    CGRect recg = [no.userInfo[@"UIKeyboardBoundsUserInfoKey"] CGRectValue];
    if (recg.origin.y != H) {
        if (recg.origin.y - _bigView.frame.origin.y < CGRectGetHeight(_bigView.frame) + 20) {
            [UIView animateWithDuration:0.25 animations:^{
                [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
                lab.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_bigView.frame)/2);
                _bigView.transform = CGAffineTransformMakeTranslation(0, -CGRectGetHeight(_bigView.frame)/2);
            }];
        }
    }
}

- (void)keyboardHide:(NSNotification *)no {
    [UIView animateWithDuration:0.25 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        _bigView.transform = CGAffineTransformIdentity;
        lab.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        //        [selfBlock removeFromSuperview];
    }];
}


- (void)show {
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    [window addSubview:self];
    [UIView animateWithDuration:.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 / 0.8 options:0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//        self.alpha = 1;
        _bigView.transform = CGAffineTransformIdentity;
        lab.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [text becomeFirstResponder];
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
