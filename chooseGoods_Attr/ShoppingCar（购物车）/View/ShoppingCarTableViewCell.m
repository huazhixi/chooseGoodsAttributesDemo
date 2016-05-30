//
//  ShoppingCarTableViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/27.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShoppingCarTableViewCell.h"
#import "BuyCarModel.h"
#import "UIImageView+WebCache.h"
#import "ACMacros.h"

@interface ShoppingCarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodImgView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *buyNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *calculateLbl;

@end

@implementation ShoppingCarTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ShoppingCarTableViewCellID = @"ShoppingCarTableViewCell";
    ShoppingCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShoppingCarTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShoppingCarTableViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)awakeFromNib {
    self.calculateView.hidden = YES;
    self.deleteBtn.hidden = YES;
    
    self.calculateView.layer.borderWidth = 1;
    self.calculateView.layer.borderColor = LXBorderColor.CGColor;
}

- (void)setBuyCarModel:(BuyCarModel *)buyCarModel {
    _buyCarModel = buyCarModel;
    
    [_goodImgView sd_setImageWithURL:[NSURL URLWithString:buyCarModel.goods_img] placeholderImage:nil];
    _goodNameLbl.text = buyCarModel.goods_name;
    _calculateLbl.text = buyCarModel.num;
    _buyNumLbl.text = [NSString stringWithFormat:@"x%@", buyCarModel.num];
    _goodPriceLbl.text = [NSString stringWithFormat:@"￥%@", buyCarModel.shop_price];
    float totalPrice = [buyCarModel.shop_price floatValue] * [buyCarModel.num intValue];
    _totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    
    if (buyCarModel.isSelected) {//判断cell的选中状态
        self.selectBtn.selected = YES;
    } else {
        self.selectBtn.selected = NO;
    }
    
    if (buyCarModel.isCalculateViewHidden) {
        self.calculateView.hidden = YES;
        _buyNumLbl.text = [NSString stringWithFormat:@"x%@", _calculateLbl.text];
        float totalPrice = [buyCarModel.shop_price floatValue] * [_calculateLbl.text intValue];
        _totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    } else {
        self.calculateView.hidden = NO;
        _buyNumLbl.text = [NSString stringWithFormat:@"x%@", _calculateLbl.text];
        float totalPrice = [buyCarModel.shop_price floatValue] * [_calculateLbl.text intValue];
        _totalPriceLbl.text = [NSString stringWithFormat:@"￥%.2f", totalPrice];
    }
}


- (IBAction)downBtnClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.selectBtnClick) {
        self.selectBtnClick(sender.selected);
    }
}

- (IBAction)pmBtnClick:(UIButton *)sender {
    int  num = [self.calculateLbl.text intValue];
    if (sender.tag == 2) {
        num += 1;
        self.calculateLbl.text = [NSString stringWithFormat:@"%d", num];
    } else {
        num -=1;
        if (num <= 0) {
            return;
        } else {
            self.calculateLbl.text = [NSString stringWithFormat:@"%d", num];
        }
    }
    if (self.pmBtnClick) {
        self.pmBtnClick(_calculateLbl.text);
    }
}

@end
