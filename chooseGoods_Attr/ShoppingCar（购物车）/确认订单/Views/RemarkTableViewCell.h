//
//  RemarkTableViewCell.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/4/19.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaceholderTextView.h"

@interface RemarkTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet PlaceholderTextView *remarkTextView;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
