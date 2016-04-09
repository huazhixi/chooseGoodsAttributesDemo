//
//  GoodsDetailViewController.m
//  chooseGoods_Attr
//
//  Created by Lingxiu on 15/12/21.
//  Copyright © 2015年 Lingxiu. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "GlobalDefine.h"
#import "LXHttpTool.h"
#import "GoodAttrModel.h"
#import "MJExtension.h"
#import "SVProgressHUD.h"
#import "GoodAttributesView.h"
#import "WZLBadgeImport.h"

@interface GoodsDetailViewController ()

@property (weak, nonatomic) IBOutlet UIButton *buyCarBtn;
@property (nonatomic, strong) NSArray *goodAttrsArr;
@end

@implementation GoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _buyCarBtn.badgeBgColor = kMAINCOLOR;
    _buyCarBtn.badgeTextColor = kWhiteColor;
    [_buyCarBtn showBadgeWithStyle:WBadgeStyleNumber value:3 animationType:WBadgeAnimTypeScale];
    
    [self getGoodAttrData];
}
/**
 *  获取 商品属性 数据
 */
- (void)getGoodAttrData {
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"goods_attr";
    paramas[@"goods_id"] = @"11";
    [LXHttpTool post:URL params:paramas success:^(id json) {
        NSLog(@"%@", json);
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            NSArray *goodAttrsArr = [GoodAttrModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            self.goodAttrsArr = goodAttrsArr;
            
        } else {
            [SVProgressHUD showErrorWithStatus:@"暂无商品属性" maskType:SVProgressHUDMaskTypeGradient];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        NSLog(@"%@", error);
    }];
}
- (IBAction)chooseAttr:(UIButton *)button {
    [self createAttributesView];
}

- (void)createAttributesView {
    __weak typeof(self) _weakSelf = self;
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

@end
