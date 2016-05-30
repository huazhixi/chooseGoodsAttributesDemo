//
//  ShortTableViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShortTableViewCell.h"
#import "AddressModel.h"

@interface ShortTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *mobileNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *addressLbl;

@end

@implementation ShortTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ShortTableViewCellID = @"ShortTableViewCellID";
    ShortTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShortTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ShortTableViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

- (void)setAddressModel:(AddressModel *)addressModel {
    _addressModel = addressModel;
    
    _nameLbl.text = addressModel.consignee;
    _mobileNumLbl.text = addressModel.mobile;
    _addressLbl.text = [NSString stringWithFormat:@"收货地址：%@%@%@", addressModel.city_addr, addressModel.street_addr, addressModel.address_xx];
}

@end
