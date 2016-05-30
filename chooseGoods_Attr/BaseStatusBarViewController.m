//
//  BaseStatusBarViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/3/26.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "BaseStatusBarViewController.h"

@interface BaseStatusBarViewController ()

@end

@implementation BaseStatusBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
// 返回白色状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
