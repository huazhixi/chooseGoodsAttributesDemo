//
//  AddAddressTableViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/23.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "AddAddressTableViewCell.h"

@implementation AddAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *AddAddressTableViewCellID = @"AddAddressTableViewCellID";
    AddAddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AddAddressTableViewCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"AddAddressTableViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

@end
