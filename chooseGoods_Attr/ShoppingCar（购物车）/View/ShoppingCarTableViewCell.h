//
//  ShoppingCarTableViewCell.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/27.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyCarModel;
@interface ShoppingCarTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^pmBtnClick)(NSString *num);
@property (nonatomic, copy) void (^selectBtnClick)(BOOL isSelecteds);

@property (nonatomic, strong) BuyCarModel *buyCarModel;

@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UIView *calculateView;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
