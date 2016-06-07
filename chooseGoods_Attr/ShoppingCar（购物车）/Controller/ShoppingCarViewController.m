//
//  ShoppingCarViewController.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/27.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShoppingCarViewController.h"
#import "ShoppingCarTableViewCell.h"
#import "ConfirmOrderViewController.h"
#import "ACMacros.h"
#import "HXHttpTool.h"
#import "SVProgressHUD.h"
#import "MJRefresh.h"
#import "MJExtension.h"
//#import "GoodDetailViewController.h"
#import "BuyCarModel.h"
#import "JXTAlertTools.h"

static float global_totalPrice = 0;
static int global_jiesuanNum = 0;

@interface ShoppingCarViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *bottomSelectBtn;
@property (weak, nonatomic) IBOutlet UIButton *bottomJiesuanBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property (weak, nonatomic) IBOutlet UIView *deleteAndCollectView;
@property (weak, nonatomic) IBOutlet UIButton *jiesuanBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomBackView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (nonatomic, strong) NSArray *carListArr;
@property (nonatomic, weak) UIButton *rightBtn;
@property (nonatomic, strong) NSMutableArray *jiesuanArr;
@property (nonatomic, strong) NSMutableArray *collectOrDeleteArr;
@end

@implementation ShoppingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupShoppingCarViewNav];
    
    // 获取 用户购物车列表
//    [self getCarListData];
    [self createShopCarData];
    
//    typeof(self) _weakSelf = self;
//    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        global_totalPrice = 0;
//        global_jiesuanNum = 0;
//        [_jiesuanBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
//        _totalPriceLbl.text = @"￥0";
//        [_weakSelf getCarListData];
//    }];
//    [self.tableView.mj_header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = kMAINCOLOR;
    for (BuyCarModel *model in self.carListArr) {
        model.isSelected = NO;
    }
    [self.tableView reloadData];
    self.bottomSelectBtn.selected = NO;
    self.jiesuanArr = nil;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 全局变量 置为0
    global_totalPrice = 0;
    global_jiesuanNum = 0;
    _totalPriceLbl.text = @"￥0";
    [_jiesuanBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
}
/**
 *  创建模拟数据
 */
- (void)createShopCarData {
    BuyCarModel *model1 = [BuyCarModel new];
    model1.goods_name = @"测试商品1";
    model1.shop_price = @"1.00";
    model1.num = @"1";
    model1.car_id = @"1";
    model1.isCalculateViewHidden = YES;
    model1.goods_img = @"http://7xq2wz.com1.z0.glb.clouddn.com/ff2a50cdacc8952ad8ccfcbb3ccae3f1.jpg";
    
    BuyCarModel *model2 = [BuyCarModel new];
    model2.goods_name = @"测试商品2";
    model2.shop_price = @"2.00";
    model2.num = @"2";
    model2.car_id = @"2";
    model2.isCalculateViewHidden = YES;
    model2.goods_img = @"http://7xq2wz.com1.z0.glb.clouddn.com/ff2a50cdacc8952ad8ccfcbb3ccae3f1.jpg";
    
    BuyCarModel *model3 = [BuyCarModel new];
    model3.goods_name = @"测试商品3";
    model3.shop_price = @"3.00";
    model3.num = @"3";
    model3.car_id = @"3";
    model3.isCalculateViewHidden = YES;
    model3.goods_img = @"http://7xq2wz.com1.z0.glb.clouddn.com/ff2a50cdacc8952ad8ccfcbb3ccae3f1.jpg";
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:1];
    [tempArr addObject:model1];
    [tempArr addObject:model2];
    [tempArr addObject:model3];
    
    self.carListArr = tempArr;
    
    [self.tableView reloadData];
    
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.carListArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    typeof(self) _weakSelf = self;
    ShoppingCarTableViewCell *cell = [ShoppingCarTableViewCell cellWithTableView:tableView];
    
    cell.buyCarModel = self.carListArr[indexPath.row];
    cell.pmBtnClick = ^ (NSString *num){
         ((BuyCarModel *)_weakSelf.carListArr[indexPath.row]).num = num;
    };
    cell.selectBtnClick = ^(BOOL isSelected) {
        BuyCarModel *model = _weakSelf.carListArr[indexPath.row];
        model.isSelected = isSelected;
        if (isSelected) {
            global_jiesuanNum += [model.num intValue];
            global_totalPrice += [model.num intValue] * [model.shop_price floatValue];
            _weakSelf.totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", global_totalPrice];
            [_weakSelf.jiesuanBtn setTitle:[NSString stringWithFormat:@"结算(%d)", global_jiesuanNum] forState:UIControlStateNormal];
            
            [_weakSelf.jiesuanArr addObject:model];
            [_weakSelf.collectOrDeleteArr addObject:model.car_id];
        } else {
            global_jiesuanNum -= [model.num intValue];
            global_totalPrice -= [model.num intValue] * [model.shop_price floatValue];
            _weakSelf.totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", global_totalPrice];
            [_weakSelf.jiesuanBtn setTitle:[NSString stringWithFormat:@"结算(%d)", global_jiesuanNum] forState:UIControlStateNormal];
            
            [_weakSelf.jiesuanArr removeObject:model];
            [_weakSelf.collectOrDeleteArr removeObject:model.car_id];
        }
        // 判断 如果有一个cell未被选中，全选按钮取消被选中
        for (BuyCarModel *model in self.carListArr) {
            if (!model.isSelected) {
                _bottomSelectBtn.selected = NO;
            }
        }
        // 判断 如果所有的cell被选中，全选按钮也被选中
        int selectCount = 0;
        for (BuyCarModel *model in self.carListArr) {
            if (model.isSelected) {
                selectCount ++;
            }
        }
        if (selectCount == self.carListArr.count) {
            _bottomSelectBtn.selected = YES;
        }
    };
    return cell;
}
#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 137;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.rightBtn.selected) {
//        GoodDetailViewController *goodDetailVC = [[GoodDetailViewController alloc] init];
//        goodDetailVC.goods_id = ((BuyCarModel *)self.carListArr[indexPath.row]).goods_id;
//        [self.navigationController pushViewController:goodDetailVC animated:YES];
    }
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    BuyCarModel *model = self.carListArr[indexPath.row];
    // 先清除当前数据
    [self.collectOrDeleteArr removeAllObjects];
    // 添加删除当前行的商品id
    [self.collectOrDeleteArr addObject:model.car_id];
    typeof(self) _weakSelf = self;
    [JXTAlertTools showAlertWith:self title:nil message:@"确认要删除该商品吗？" callbackBlock:^(NSInteger btnIndex) {
        if (btnIndex == 1) {
            // 操作删除当前行
//            [_weakSelf getCarDelData];
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
}
#pragma mark -  页面按钮点击事件
- (IBAction)bottomBtnClick:(UIButton *)button {
    if (button.tag == 1) { // 全选事件
        button.selected = !button.selected;
        if (button.selected) {
            self.bottomSelectBtn.selected = YES;
            int i = 0;
            float totalCount = 0;
            for (BuyCarModel *model in self.carListArr) {
                model.isSelected = YES;
                float total = [model.num intValue]  * [model.shop_price floatValue];
                totalCount += total;
                i += [model.num intValue];
                
                [self.jiesuanArr addObject:model];
                [self.collectOrDeleteArr addObject:model.car_id];
            }
            global_jiesuanNum = i;
            global_totalPrice = totalCount;
            [_jiesuanBtn setTitle:[NSString stringWithFormat:@"结算(%d)", i] forState:UIControlStateNormal];
            _totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalCount];
            
            // 刷新表格
            [self.tableView reloadData];
        } else {
            self.bottomSelectBtn.selected = NO;
            for (BuyCarModel *model in self.carListArr) {
                model.isSelected = NO;
                
                [self.jiesuanArr removeObject:model];
                [self.collectOrDeleteArr removeObject:model.cat_id];
            }
            [_jiesuanBtn setTitle:@"结算(0)" forState:UIControlStateNormal];
            _totalPriceLbl.text = @"￥0";
            global_jiesuanNum = 0;
            global_totalPrice = 0;
            // 刷新表格
            [self.tableView reloadData];
        }
    } else if (button.tag == 2) { //结算事件
        if (![_jiesuanBtn.titleLabel.text isEqualToString:@"结算(0)"]) {
            ConfirmOrderViewController *confirmOrderVC = [[ConfirmOrderViewController alloc] init];
            confirmOrderVC.buyStatus = @"1";
            confirmOrderVC.buyCarArr = self.jiesuanArr;
            [self.navigationController pushViewController:confirmOrderVC animated:YES];
        }
    } else if (button.tag == 3) { //删除事件
        if (self.collectOrDeleteArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"请选择删除数据"];
        } else {
            // 删除选中的物品
            [JXTAlertTools showAlertWith:self title:@"确定删除当前选定的商品？" message:nil callbackBlock:^(NSInteger btnIndex) {
                if (btnIndex == 1) {
//                    [self getCarDelData];
                }
            }  cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil, nil];
        }
    }else if (button.tag == 4) { // 添加收藏
        if (self.collectOrDeleteArr.count == 0) {
            [SVProgressHUD showErrorWithStatus:@"未选择删除数据"];
        }
    }
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
    self.rightBtn = rightBtn;
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
            for (BuyCarModel *model in _weakSelf.carListArr) {
                model.isCalculateViewHidden = NO;
            }
            [_weakSelf.tableView reloadData];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            _deleteAndCollectView.hidden = YES;
            _countLabel.hidden = NO;
            _totalPriceLbl.hidden = NO;
        } completion:^(BOOL finished) {
            for (BuyCarModel *model in _weakSelf.carListArr) {
                model.isCalculateViewHidden = YES;
            }
            [_weakSelf.tableView reloadData];
        }];
        int jiesuanNum = 0;
        float totalPrice = 0;
        for (BuyCarModel *model in self.carListArr) {
            if (model.isSelected) {
                jiesuanNum += [model.num intValue];
                totalPrice += [model.num intValue] * [model.shop_price floatValue];
                self.totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
                [self.jiesuanBtn setTitle:[NSString stringWithFormat:@"结算(%d)", jiesuanNum] forState:UIControlStateNormal];
            }
        }
        global_jiesuanNum = jiesuanNum;
        global_totalPrice = totalPrice;
    }
}
#pragma mark - 懒加载
- (NSMutableArray *)jiesuanArr {
    if (!_jiesuanArr) {
        self.jiesuanArr  = [NSMutableArray arrayWithCapacity:1];
    }
    return _jiesuanArr;
}
- (NSMutableArray *)collectOrDeleteArr {
    if (!_collectOrDeleteArr) {
        self.collectOrDeleteArr  = [NSMutableArray arrayWithCapacity:1];
    }
    return _collectOrDeleteArr;
}
- (NSArray *)carListArr {
    if (!_carListArr) {
        self.carListArr  = [[NSArray alloc] init];
    }
    return _carListArr;
}


/**
 *  获取 用户购物车列表
 */
//- (void)getCarListData {
//    typeof(self) _weakSelf = self;
//    self.carListArr = nil;
//    NSString *userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
//    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
//    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
//    paramas[@"method"] = @"carlist";
//    paramas[@"user_id"] = userID;
//    [HXHttpTool post:URL params:paramas success:^(id json) {
//        LXLog(@"%@", json);
//        NSInteger status = [json[@"status"] integerValue];
//        if (status == 1) {
//            self.carListArr = [BuyCarModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
////            LXLog(@"%ld", self.carListArr.count);
//            for (BuyCarModel *model in self.carListArr) {
//                model.isCalculateViewHidden = YES;
//            }
//        } else {
//            // 提示框
//            [SVProgressHUD showErrorWithStatus:@"请去添加商品"];
//        }
//        [_weakSelf.tableView reloadData];
//
//        // 在清空数组时，要先更新数组再结束刷新，不然就会出现数组还为空，造成程序crash
//        [self.tableView.mj_header endRefreshing];
//    } failure:^(NSError *error) {
//        [self.tableView.mj_header endRefreshing];
//        [SVProgressHUD showErrorWithStatus:@"请重新加载"];
//        LXLog(@"%@", error);
//    }];
//}
/**
 *  购物车删除接口
 */
//- (void)getCarDelData {
//    NSString *tempStr = @"";
//    for (id str  in _collectOrDeleteArr) {
//        tempStr = [tempStr stringByAppendingString:[NSString stringWithFormat:@"-%@", str]];
//    }
//    LXLog(@"%@",tempStr);
//    NSString *car_idStr = [tempStr substringFromIndex:1];
//    typeof(self) _weakSelf = self;
//    NSString *URL = [NSString stringWithFormat:@"%@/App/Sylm/yclist",SERVERURL];
//    NSMutableDictionary *paramas = [NSMutableDictionary dictionary];
//    paramas[@"method"] = @"cardel";
//    paramas[@"car_id"] = car_idStr;
//    LXLog(@"%@", paramas);
//    [HXHttpTool post:URL params:paramas success:^(id json) {
//        LXLog(@"%@", json);
//        NSInteger status = [json[@"status"] integerValue];
//        if (status == 1) {
//            [_weakSelf.tableView.mj_header beginRefreshing];
//        } else {
//            // 提示框
//            [SVProgressHUD showErrorWithStatus:@"删除失败"];
//        }
//    } failure:^(NSError *error) {
//        [SVProgressHUD showErrorWithStatus:@"请重新加载"];
//        LXLog(@"%@", error);
//    }];
//}

@end
