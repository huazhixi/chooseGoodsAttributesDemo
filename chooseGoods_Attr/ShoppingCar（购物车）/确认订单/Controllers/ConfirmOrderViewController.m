//
//  ConfirmOrderViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ShortTableViewCell.h"
#import "ConfirmOrderTableViewCell.h"
#import "PayBigCell.h"
#import "ShouhuoDIzhiViewController.h"
#import "ACMacros.h"
#import "HXHttpTool.h"
#import "SVProgressHUD.h"
#import "AddressModel.h"
#import "MJExtension.h"
#import "AddAddressTableViewCell.h"
#import "ChooseAddressViewController.h"
#import "BuyCarModel.h"
#import "ConfirmOrderModel.h"
//#import "Pingpp.h"
#import "PaySuccessViewController.h"
#import "RemarkTableViewCell.h"

@interface ConfirmOrderViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *addressArr;
@property (nonatomic, copy) NSString *ways;
@property (nonatomic, strong) RemarkTableViewCell *remarkCell;
@end
@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    float totalCount = 0;
    for (BuyCarModel *model in _buyCarArr) {
        totalCount += [model.shop_price floatValue] * [model.num intValue];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterSuccessView) name:@"enterSuccessView" object:nil];
    
    self.totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalCount];
    // 获取用户地址列表数据
//    [self getAddrlistData];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    _ways = nil;
}
- (void)enterSuccessView {
    ConfirmOrderModel *model = _buyCarArr[0];
    PaySuccessViewController *payVC = [[PaySuccessViewController alloc] init];
    payVC.fromStr = @"SYLM";
    payVC.name = model.goods_name;
    payVC.shop_price = model.shop_price;
    [self.navigationController pushViewController:payVC animated:YES];
}
/**
 *  获取用户地址列表数据
 */
- (void)getAddrlistData {
    [SVProgressHUD show];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    typeof(self) _weakSelf = self;
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"addrlist";
    paramas[@"user_id"] = userID;
    [HXHttpTool post:URL params:paramas success:^(id json) {
        [SVProgressHUD dismiss];
        //        LXLog(@"%@", json);
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            _weakSelf.addressArr = [AddressModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            if (_weakSelf.addressArr.count == 0) {
                _weakSelf.addressModel = nil;
            } else {
                for (AddressModel *model in self.addressArr) {
                    if ([model.moren_status isEqual:@"1"]) {
                        _weakSelf.addressModel = model;
                    }
                }
            }
            [_weakSelf.tableView reloadData];
        } else {
            [_weakSelf.tableView reloadData];
            // 提示框
//            [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"网络问题" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];
}

- (IBAction)sureBtnClick {
    if (!_addressModel) {
        [SVProgressHUD showErrorWithStatus:@"请先添加收货地址" maskType:SVProgressHUDMaskTypeGradient];
        return;
    }
    if (self.ways == nil) {
        [SVProgressHUD showErrorWithStatus:@"请选择支付方式..." maskType:SVProgressHUDMaskTypeGradient];
        return;
    }
    if ([self.buyStatus isEqual:@"0"]) {
        [self lootNowAddOrderData];
    } else {
        NSMutableString *carid = [NSMutableString stringWithCapacity:1];
        for (BuyCarModel *model in _buyCarArr) {
            NSString *tempStr = [NSMutableString stringWithFormat:@"%@-%@", model.car_id, model.num];
            [carid appendFormat:@"%@|", tempStr];
        }
        NSString *appendCarID = [carid substringToIndex:carid.length - 1];
        [self buyCarAddOrderDataWithCarid_count:appendCarID];
    }
}
/**
 *  确认支付订单
 */
- (void)buyCarAddOrderDataWithCarid_count:(NSString *)carid_count {
    typeof(self) _weakSelf = self;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"addorder";
    paramas[@"buy_status"] = _buyStatus;
    paramas[@"carid_count"] = carid_count;
    paramas[@"user_id"] = userID;
    paramas[@"ways"] = self.ways;
    paramas[@"addr_id"] = self.addressModel.address_id;
    [HXHttpTool post:URL params:paramas success:^(id json) {
        LXLog(@"%@", json);
//        [_weakSelf wakeUpPingWithCharge:json];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"调取支付失败" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];
}
/**
 *  确认支付订单
 */
- (void)lootNowAddOrderData {
    [SVProgressHUD show];
    typeof(self) _weakSelf = self;
    ConfirmOrderModel *model = _buyCarArr[0];
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"addorder";
    paramas[@"buy_status"] = @"0";
    paramas[@"user_id"] = userID;
    paramas[@"addr_id"] = self.addressModel.address_id;
    paramas[@"goods_id"] = model.goods_id;
    paramas[@"num"] = model.num;
    paramas[@"ways"] = self.ways;
    paramas[@"product_id"] = self.product_id;
    paramas[@"order_content"] = _remarkCell.remarkTextView.text;
    [HXHttpTool post:URL params:paramas success:^(id json) {
        [SVProgressHUD dismiss];
        LXLog(@"%@", json);
//        [_weakSelf wakeUpPingWithCharge:json];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:@"调取支付失败" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];
}
//- (void)wakeUpPingWithCharge:(NSString *)charge {
//    typeof(self) _weakSelf = self;
//    [Pingpp createPayment:charge
//           viewController:self
//             appURLScheme:kURLScheme
//           withCompletion:^(NSString *result, PingppError *error) {
//               if ([result isEqualToString:@"success"]) {
//                   // 支付成功
//                   [SVProgressHUD showSuccessWithStatus:@"支付成功" maskType:SVProgressHUDMaskTypeGradient];
//                   
//                   [_weakSelf gotoSuccessVC];
//               } else {
//                   // 支付失败或取消
//                   LXLog(@"Error: code=%lu msg=%@", error.code, [error getMsg]);
//                   [SVProgressHUD showErrorWithStatus:@"取消支付" maskType:SVProgressHUDMaskTypeGradient];
//               }
//           }];
//}
- (void)gotoSuccessVC {
    ConfirmOrderModel *model = _buyCarArr[0];
    PaySuccessViewController *payVC = [[PaySuccessViewController alloc] init];
    payVC.fromStr = @"SYLM";
    payVC.name = model.goods_name;
    payVC.shop_price = model.shop_price;
    [self.navigationController pushViewController:payVC animated:YES];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.buyCarArr.count + 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    typeof(self) _weakSelf = self;
    if (indexPath.row == 0) {
        if (self.addressArr.count == 0) {
            AddAddressTableViewCell *cell = [AddAddressTableViewCell cellWithTableView:tableView];
            return cell;
        } else {
            ShortTableViewCell *cell = [ShortTableViewCell cellWithTableView:tableView];
            cell.addressModel = self.addressModel;
            return cell;
        }
    } else if (indexPath.row == self.buyCarArr.count+1) {
        RemarkTableViewCell *cell = [RemarkTableViewCell cellWithTableView:tableView];
        _remarkCell = cell;
        
        return cell;
    } else if (indexPath.row == self.buyCarArr.count +2) {
        PayBigCell *cell = [PayBigCell cellWithTableView:tableView];
        cell.payBtnClick = ^(NSString *ways) {
            _weakSelf.ways = ways;
        };
        return cell;
    } else {
        ConfirmOrderTableViewCell *cell = [ConfirmOrderTableViewCell cellWithTableView:tableView];
        cell.orderModel = self.buyCarArr[indexPath.row - 1];
        return cell;
    }
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if (self.addressArr.count == 0) {
            return 44;
        } else {
            return 90;
        }
    } else if (indexPath.row == self.buyCarArr.count+1) {
        return 147;
    } else if (indexPath.row == self.buyCarArr.count + 2) {
        return 290;
    } else {
        return 190;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    typeof(self) _weakSelf = self;
    if (indexPath.row == 0) {
        ChooseAddressViewController *chooseAddressVC = [[ChooseAddressViewController alloc] initWithNibName:@"ShouhuoDIzhiViewController" bundle:nil];
        chooseAddressVC.didRowAtIndexPath = ^(AddressModel *addressModel){
            _weakSelf.addressModel = addressModel;
            [_weakSelf.tableView reloadData];
        };
        [_weakSelf.navigationController pushViewController:chooseAddressVC animated:YES];
    }
}

- (IBAction)backBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

//滑动收回键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}


#pragma mark - 懒加载
- (AddressModel *)addressModel {
    if (!_addressModel) {
        self.addressModel  = [[AddressModel alloc] init];
    }
    return _addressModel;
}
- (NSArray *)addressArr {
    if (!_addressArr) {
        self.addressArr  = [[NSArray alloc] init];
    }
    return _addressArr;
}
@end
