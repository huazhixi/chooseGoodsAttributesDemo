//
//  ChooseAddressViewController.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/23.
//  Copyright © 2016年 zym. All rights reserved.
//

#import "ShouhuoDIzhiViewController.h"
@class AddressModel;
@interface ChooseAddressViewController : ShouhuoDIzhiViewController

@property (nonatomic, copy) void (^didRowAtIndexPath)(AddressModel *addressModel);
@end
