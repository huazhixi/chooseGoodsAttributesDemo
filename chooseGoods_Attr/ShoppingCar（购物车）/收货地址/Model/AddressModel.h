//
//  AddressModel.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/22.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

/** 联系方式 */
@property (nonatomic, copy) NSString *mobile;
/** 收货人名字 */
@property (nonatomic, copy) NSString *consignee;
/** 邮编 */
@property (nonatomic, copy) NSString *zipcode;
/** 地址号 */
@property (nonatomic, copy) NSString *address_id;
/** 详细地址 */
@property (nonatomic, copy) NSString *address_xx;
/** id */
@property (nonatomic, copy) NSString *user_id;
/** 省市区 */
@property (nonatomic, copy) NSString *city_addr;
/** 街道 */
@property (nonatomic, copy) NSString *street_addr;
/** 0，不是默认，1，默认地址 */
@property (nonatomic, copy) NSString *moren_status;

@end
