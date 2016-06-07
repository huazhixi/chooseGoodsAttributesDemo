//
//  GoodsDetailViewController.m
//  chooseGoods_Attr
//
//  Created by Lingxiu on 15/12/21.
//  Copyright © 2015年 Lingxiu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GlobalDefine.h"
#import "HXHttpTool.h"
#import "GoodAttrModel.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GoodAttributesView.h"
#import "WZLBadgeImport.h"
#import "ShoppingCarViewController.h"

@interface GoodsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buyCarBtn;
@property (nonatomic, strong) NSArray *goodAttrsArr;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buyCarBtn.badgeBgColor = kMAINCOLOR;
    _buyCarBtn.badgeTextColor = kWhiteColor;
    
    [self createData];
    
    [_buyCarBtn showBadgeWithStyle:WBadgeStyleNumber value:3 animationType:WBadgeAnimTypeScale];
    
//    [self getGoodAttrData];
}
- (void)createData {
    GoodAttrModel *model0 = [GoodAttrModel new];
    model0.attr_id = @"10";
    model0.attr_name = @"尺寸";
    GoodAttrValueModel *value1 = [GoodAttrValueModel new];
    value1.attr_value = @"165";
    GoodAttrValueModel *value2 = [GoodAttrValueModel new];
    value2.attr_value = @"170";
    GoodAttrValueModel *value3 = [GoodAttrValueModel new];
    value3.attr_value = @"175";
    GoodAttrValueModel *value4 = [GoodAttrValueModel new];
    value4.attr_value = @"180";
    GoodAttrValueModel *value5 = [GoodAttrValueModel new];
    value5.attr_value = @"185";
    GoodAttrValueModel *value6 = [GoodAttrValueModel new];
    value6.attr_value = @"190";
    model0.attr_value = [NSArray arrayWithObjects:value1, value2, value3, value4, value5, value6, nil];
    
    GoodAttrModel *model1 = [GoodAttrModel new];
    model1.attr_id = @"11";
    model1.attr_name = @"颜色";
    GoodAttrValueModel *value10 = [GoodAttrValueModel new];
    value10.attr_value = @"红色";
    GoodAttrValueModel *value20 = [GoodAttrValueModel new];
    value20.attr_value = @"蓝色";
    GoodAttrValueModel *value30 = [GoodAttrValueModel new];
    value30.attr_value = @"橘红色";
    GoodAttrValueModel *value40 = [GoodAttrValueModel new];
    value40.attr_value = @"藏青色";
    GoodAttrValueModel *value50 = [GoodAttrValueModel new];
    value50.attr_value = @"肚子疼";
    GoodAttrValueModel *value60 = [GoodAttrValueModel new];
    value60.attr_value = @"一条虫";
    model1.attr_value = [NSArray arrayWithObjects:value10, value20, value30, value40, value50, value60, nil];
    
    self.goodAttrsArr = [NSArray arrayWithObjects:model0, model1, nil];
}
- (IBAction)chooseAttr:(UIButton *)button {
    [self createAttributesView];
}
- (IBAction)enterShopCar:(id)sender {
    ShoppingCarViewController *shopCarVC = [ShoppingCarViewController new];
    [self.navigationController pushViewController:shopCarVC animated:YES];
}

- (void)createAttributesView {
//    __weak typeof(self) _weakSelf = self;
    GoodAttributesView *attributesView = [[GoodAttributesView alloc] initWithFrame:(CGRect){0, 0, kScreenW, kScreenH}];
    attributesView.goodAttrsArr = self.goodAttrsArr;
//    attributesView.good_img = self.goodDetailModel.goods_img;
//    attributesView.good_name = self.goodDetailModel.goods_name;
//    attributesView.good_price = self.goodDetailModel.shop_price;
    attributesView.sureBtnsClick = ^(NSString *num, NSString *attrs, NSString *goods_attr_value_1, NSString *goods_attr_value_2) {
        NSLog(@"\n购物数量：%@ \n 第一个属性：%@ \n 第二个属性：%@", num, goods_attr_value_1, goods_attr_value_2);
    };
    [attributesView showInView:self.navigationController.view];
}

///**
// *  获取 商品属性 数据
// */
//- (void)getGoodAttrData {
//
//    // 后台服务器返回的数据格式，在最下面，仅供参考
//
//    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
//    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
//    paramas[@"method"] = @"goods_attr";
//    paramas[@"goods_id"] = @"11";
//    [LXHttpTool post:URL params:paramas success:^(id json) {
//        NSLog(@"%@", json);
//        NSInteger status = [json[@"status"] integerValue];
//        if (status == 1) {
//            NSArray *goodAttrsArr = [GoodAttrModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//            self.goodAttrsArr = goodAttrsArr;
//
//        } else {
//            [SVProgressHUD showErrorWithStatus:@"暂无商品属性" maskType:SVProgressHUDMaskTypeGradient];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
//        NSLog(@"%@", error);
//    }];
//}

// 服务器返回的数据格式,仅供参考
//{
//    data =     (
//                {
//                    "attr_id" = 10;
//                    "attr_name" = "\U5c3a\U7801";
//                    "attr_value" =             (
//                                                {
//                                                    "attr_value" = 165;
//                                                },
//                                                {
//                                                    "attr_value" = 160;
//                                                }
//                                                );
//                },
//                {
//                    "attr_id" = 11;
//                    "attr_name" = "\U989c\U8272";
//                    "attr_value" =             (
//                                                {
//                                                    "attr_value" = "\U7ea2\U8272";
//                                                },
//                                                {
//                                                    "attr_value" = "\U9ed1\U8272";
//                                                }
//                                                );
//                }
//                );
//    status = 1;
//}
@end
