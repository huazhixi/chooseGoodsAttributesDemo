//
//  PayBigCell.h
//  AiMeiBang
//
//  Created by LingXiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PayBigCellDelegate <NSObject>

- (void)getButtonTag:(NSInteger)tag;

@end


@interface PayBigCell : UITableViewCell

@property (nonatomic, copy) void (^payBtnClick)(NSString *ways);

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, assign) id<PayBigCellDelegate> delegate;

@end
