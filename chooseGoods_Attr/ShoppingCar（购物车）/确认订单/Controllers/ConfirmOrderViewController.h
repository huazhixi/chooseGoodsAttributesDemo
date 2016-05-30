//
//  ConfirmOrderViewController.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/1/28.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "BaseStatusBarViewController.h"
@class AddressModel;
@interface ConfirmOrderViewController : BaseStatusBarViewController

@property (nonatomic, strong) AddressModel *addressModel;
@property (nonatomic, strong) NSArray *buyCarArr;

@property (nonatomic, copy) NSString *buyStatus;
@property (nonatomic, copy) NSString *product_id;
@property (nonatomic, copy) NSString *num;
@end
