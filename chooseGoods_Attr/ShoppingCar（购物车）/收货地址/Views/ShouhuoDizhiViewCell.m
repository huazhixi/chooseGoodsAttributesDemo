//
//  ShouhuoDizhiViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/25.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShouhuoDizhiViewCell.h"
#import "AddressModel.h"
#import "ACMacros.h"

@interface ShouhuoDizhiViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;
@end

@implementation ShouhuoDizhiViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ShouhuoDizhiViewCellID = @"ShouhuoDizhiViewCellID";
    ShouhuoDizhiViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShouhuoDizhiViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShouhuoDizhiViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)setAddressModel:(AddressModel *)addressModel {
    _addressModel = addressModel;
    
    _nameLbl.text = addressModel.consignee;
    _phoneNumLbl.text = addressModel.mobile;
    
    NSString *addressStr = [NSString stringWithFormat:@"%@%@%@", addressModel.city_addr, addressModel.street_addr, addressModel.address_xx];
    if ([addressModel.moren_status isEqual:@"1"]) {
//        _defaultLblW.constant = 0;
        NSString *contentStr = [NSString stringWithFormat:@"[默认]%@", addressStr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:contentStr];
        //设置：在0-3个单位长度内的内容显示成红色
        [str addAttribute:NSForegroundColorAttributeName value:kMAINCOLOR range:NSMakeRange(0, 4)];
        _addressLbl.attributedText = str;
    } else {
        _addressLbl.text = addressStr;
    }
    
}
@end
