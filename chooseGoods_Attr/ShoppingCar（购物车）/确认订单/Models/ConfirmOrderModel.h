//
//  ConfirmOrderModel.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/26.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConfirmOrderModel : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *goods_id;
/** 服务商号 */
@property (nonatomic, copy) NSString *goods_sn;
/** 商品图片 */
@property (nonatomic, copy) NSString *goods_img;
/** 商品名字 */
@property (nonatomic, copy) NSString *goods_name;
/** 店内价格 */
@property (nonatomic, copy) NSString *shop_name;
/** 店内价格 */
@property (nonatomic, copy) NSString *shop_price;
/** 商品数量 */
@property (nonatomic, copy) NSString *num;
@end
