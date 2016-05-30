//
//  ConfirmOrderTableViewCell.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@class BuyCarModel;
@interface ConfirmOrderTableViewCell : UITableViewCell

@property (nonatomic, strong) BuyCarModel *orderModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
