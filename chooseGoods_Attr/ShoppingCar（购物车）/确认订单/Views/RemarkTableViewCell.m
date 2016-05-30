//
//  RemarkTableViewCell.m
//  AiMeiBang
//
//  Created by Lingxiu on 16/4/19.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "RemarkTableViewCell.h"
#import "ACMacros.h"

@implementation RemarkTableViewCell

- (void)awakeFromNib {
    self.remarkTextView.placeholder = @"你对订单有什么特殊说明，可以在此备注";
    self.remarkTextView.placeholderColor = LXBorderColor;
    self.remarkTextView.placeholderFont = [UIFont systemFontOfSize:13];
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *RemarkTableVieIDwCellID = @"RemarkTableViewCellID";
    RemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RemarkTableVieIDwCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"RemarkTableViewCell" owner:self options:nil].lastObject;
    }
    return cell;
}

@end
