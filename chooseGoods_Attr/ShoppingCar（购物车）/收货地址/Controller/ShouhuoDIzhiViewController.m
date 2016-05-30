//
//  ShouhuoDIzhiViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShouhuoDIzhiViewController.h"
#import "ShouhuoDizhiViewCell.h"
#import "HXHttpTool.h"
#import "ACMacros.h"
#import "SVProgressHUD.h"
#import "AddressModel.h"
#import "MJExtension.h"
#import "AddDizhiViewController.h"
#import "MJRefresh.h"
#import "CheckDizhiViewController.h"

@interface ShouhuoDIzhiViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ShouhuoDIzhiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收货地址管理";
    
    [self.bottomBtn addTarget:self action:@selector(bottomBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    // 获取用户地址列表数据
    [self getAddrlistData];
}
/**
 *  获取用户地址列表数据
 */
- (void)getAddrlistData {
    typeof(self) _weakSelf = self;
    self.addressArr = nil;
    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
    paramas[@"method"] = @"addrlist";
    paramas[@"user_id"] = userID;
    [HXHttpTool post:URL params:paramas success:^(id json) {
//        LXLog(@"%@", json);
        NSInteger status = [json[@"status"] integerValue];
        if (status == 1) {
            _weakSelf.addressArr = [AddressModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
            
            [_weakSelf.tableView reloadData];
        } else {
            // 提示框
            [SVProgressHUD showErrorWithStatus:@"请添加收货地址" maskType:SVProgressHUDMaskTypeGradient];
            [_weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请重新加载" maskType:SVProgressHUDMaskTypeGradient];
        LXLog(@"%@", error);
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.addressArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShouhuoDizhiViewCell *cell = [ShouhuoDizhiViewCell cellWithTableView:tableView];
    cell.addressModel = self.addressArr[indexPath.row];
    
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressModel *addressModel = self.addressArr[indexPath.row];
    CheckDizhiViewController *checkVC = [[CheckDizhiViewController alloc] init];
    checkVC.addressModel = addressModel;
    [self.navigationController pushViewController:checkVC animated:YES];
}
- (void)bottomBtnClick {
    AddDizhiViewController *addDizhiVC = [[AddDizhiViewController alloc] init];
    [self.navigationController pushViewController:addDizhiVC animated:YES];
}
#pragma mark - 懒加载
- (NSArray *)addressArr {
    if (!_addressArr) {
        self.addressArr  = [[NSArray alloc] init];
    }
    return _addressArr;
}

@end
