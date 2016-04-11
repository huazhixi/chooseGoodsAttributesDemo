//
//  ShoppingCarViewController.m
//  chooseGoods_Attr
//
//  Created by Lingxiu on 16/4/11.
//  Copyright © 2016年 Lingxiu. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "GlobalDefine.h"

@interface ShoppingCarViewController ()

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = kMAINCOLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : kWhiteColor};
}


@end
