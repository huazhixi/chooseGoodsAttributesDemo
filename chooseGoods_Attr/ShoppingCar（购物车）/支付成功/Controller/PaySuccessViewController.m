//
//  PaySuccessViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/3/9.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "PaySuccessViewController.h"
//#import "MRDZ_ServerDetailModel.h"
//#import "MyDingzhiViewController.h"
//#import "GoodDetailModel.h"
//#import "MyDingdanViewController.h"

@interface PaySuccessViewController ()

@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UIButton *dingdanButton;
@end

@interface PaySuccessViewController ()

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"支付成功";
    
    self.dingdanButton.layer.masksToBounds = YES;
    self.dingdanButton.layer.cornerRadius = 6;
    
    [self createNavigation];
    
    _NameLabel.text = _name;
    _moneyLabel.text = [NSString stringWithFormat:@"%@元", _shop_price];
}
//导航栏
-(void)createNavigation{
    UIButton *rightButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setImage:[UIImage imageNamed:@"返回"] forState:0];
    UIBarButtonItem *rightBarbutton = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.leftBarButtonItem = rightBarbutton;
}

- (void)doneAction:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
//- (IBAction)buttonAction:(UIButton *)sender {
//    if ([_fromStr isEqual:@"MRDZ"]) {
//        MyDingzhiViewController *dingzhiVC = [[MyDingzhiViewController alloc] init];
//        dingzhiVC.title = @"我的国际美容定制";
//        [self.navigationController pushViewController:dingzhiVC animated:YES];
//    } else {
//        MyDingdanViewController *dingdanVC = [MyDingdanViewController new];
//        dingdanVC.title = @"我的订单";
//        [self.navigationController pushViewController:dingdanVC animated:YES];
//    }
//}
@end
