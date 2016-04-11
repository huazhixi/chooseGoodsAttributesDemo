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


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *bottomSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomJiesuanBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property (weak, nonatomic) IBOutlet UIView *deleteAndCollectView;
@property (weak, nonatomic) IBOutlet UIButton *jiesuanBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupShoppingCarViewNav];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = kMAINCOLOR;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : kWhiteColor};
}

/**
 *  设置导航栏
 */
- (void)setupShoppingCarViewNav {
    self.title = @"购物车";
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:(CGRect){10, 10, 44, 44}];
    [rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [rightBtn setTitle:@"完成" forState:UIControlStateSelected];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [rightBtn addTarget:self action:@selector(rightBarItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.rightBtn = rightBtn;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)rightBarItemBtnClick:(UIButton *)button {
    button.selected = !button.selected;
    typeof(self) _weakSelf = self;
    if (button.selected) {
        [UIView animateWithDuration:0.3 animations:^{
            _deleteAndCollectView.hidden = NO;
            _countLabel.hidden = YES;
            _totalPriceLbl.hidden = YES;
        } completion:^(BOOL finished) {

        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _deleteAndCollectView.hidden = YES;
            _countLabel.hidden = NO;
            _totalPriceLbl.hidden = NO;
        } completion:^(BOOL finished) {
                
        }];

    }
}
@end
