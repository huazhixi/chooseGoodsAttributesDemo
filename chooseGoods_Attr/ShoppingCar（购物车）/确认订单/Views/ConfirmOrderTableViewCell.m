//
//  ConfirmOrderTableViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "BuyCarModel.h"
#import "ACMacros.h"

@interface ConfirmOrderTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *shop_nameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *good_imgView;
@property (weak, nonatomic) IBOutlet UILabel *good_nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *shop_priceLbl;
@property (weak, nonatomic) IBOutlet UILabel *numLbl;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;

@end

@implementation ConfirmOrderTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ConfirmOrderTableViewCellID = @"ConfirmOrderTableViewCellID";
    ConfirmOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ConfirmOrderTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ConfirmOrderTableViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)setOrderModel:(BuyCarModel *)orderModel {
    _orderModel = orderModel;
    
    [_good_imgView sd_setImageWithURL:[NSURL URLWithString:orderModel.goods_img] placeholderImage:nil];
    _good_nameLbl.text = orderModel.goods_name;
    _shop_nameLbl.text = orderModel.shop_name;
    _shop_priceLbl.text  = [NSString stringWithFormat:@"%@元", orderModel.shop_price];
    _numLbl.text = [NSString stringWithFormat:@"x%@", orderModel.num];
    float totalPrice = [orderModel.shop_price floatValue] * [orderModel.num intValue];
    _totalPriceLbl.text = [NSString stringWithFormat:@"%.2f元", totalPrice];
//    if (orderModel.postage) {
//        
//    }
}
@end
