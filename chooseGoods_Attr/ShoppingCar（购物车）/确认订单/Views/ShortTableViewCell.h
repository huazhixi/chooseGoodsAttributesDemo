//
//  ShortTableViewCell.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@interface ShortTableViewCell : UITableViewCell

@property (nonatomic, strong) AddressModel *addressModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
