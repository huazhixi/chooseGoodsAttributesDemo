//
//  PayBigCell.m
//  AiMeiBang
//
//  Created by LingXiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "PayBigCell.h"
#import "ACMacros.h"
#import "UIView+MaterialDesign.h"

@interface PayBigCell ()
@property (weak, nonatomic) IBOutlet UILabel *lineLabel;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoButton;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoSmallButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinButton;
@property (weak, nonatomic) IBOutlet UIButton *weixinSmallButton;
@property (weak, nonatomic) IBOutlet UIButton *yinlianButton;
@property (weak, nonatomic) IBOutlet UIButton *yinlianSmallButton;
@property (weak, nonatomic) IBOutlet UIImageView *zhifubaoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *weixinImageView;
@property (weak, nonatomic) IBOutlet UIImageView *yinlianImageView;

@end

@implementation PayBigCell

- (void)awakeFromNib {
    self.zhifubaoImageView.layer.borderWidth = 1;
    self.zhifubaoImageView.layer.borderColor = HX_RGB(200, 200, 200).CGColor;
    self.weixinImageView.layer.borderWidth = 1;
    self.weixinImageView.layer.borderColor = HX_RGB(200, 200, 200).CGColor;
    self.yinlianImageView.layer.borderWidth = 1;
    self.yinlianImageView.layer.borderColor = HX_RGB(200, 200, 200).CGColor;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *PayBigCellID = @"PayBigCellID";
    PayBigCell *cell = [tableView dequeueReusableCellWithIdentifier:PayBigCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"PayBigCell" owner:self options:nil].lastObject;
    }
    return cell;
}
- (IBAction)payMethodBtnClick:(UIButton *)button event:(UIEvent *)event {
    CGPoint position = [[[event allTouches] anyObject] locationInView:button];
    [button mdInflateAnimatedFromPoint:position backgroundColor:kMaterial_MAINCOLOR duration:0.5 completion:^ {
        button.backgroundColor = [UIColor clearColor];
    }];
    
    if (button.tag == 0) {
        self.zhifubaoSmallButton.selected = YES;
        self.weixinSmallButton.selected = NO;
        self.yinlianSmallButton.selected = NO;
    }
    if (button.tag == 1) {
        self.weixinSmallButton.selected = YES;
        self.zhifubaoSmallButton.selected = NO;
        self.yinlianSmallButton.selected = NO;
    }
    if (button.tag == 2) {
        self.yinlianSmallButton.selected = YES;
        self.zhifubaoSmallButton.selected = NO;
        self.weixinSmallButton.selected = NO;
    }
    NSString *ways = [NSString stringWithFormat:@"%ld", button.tag + 1];
    if (self.payBtnClick) {
        self.payBtnClick(ways);
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(getButtonTag:)]) {
        [self.delegate getButtonTag:button.tag + 1];
    }
    
}



@end
