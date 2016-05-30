//
//  ChooseAddressViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/23.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ChooseAddressViewController.h"
#import "ShouhuoDIzhiViewController.h"
#import "AddressModel.h"
#import "ConfirmOrderViewController.h"

@interface ChooseAddressViewController ()

@end

@implementation ChooseAddressViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"确认订单";
    
    [self.bottomBtn setTitle:@"管理收货地址" forState:UIControlStateNormal];
}

- (void)bottomBtnClick {
    ShouhuoDIzhiViewController *shouhuoDizhiVC = [[ShouhuoDIzhiViewController alloc] init];
    [self.navigationController pushViewController:shouhuoDizhiVC animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController popViewControllerAnimated:YES];
    AddressModel *addressModel = self.addressArr[indexPath.row];
    if (self.didRowAtIndexPath) {
        self.didRowAtIndexPath(addressModel);
    }
}
@end
