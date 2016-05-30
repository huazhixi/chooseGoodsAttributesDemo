//
//  BuyCarModel.h
//  AiMeiBang
//
//  Created by Lingxiu on 16/2/24.
//  Copyright © 2016年 zym. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BuyCarModel : NSObject

/** 商品id */
@property (nonatomic, copy) NSString *is_on_sale;
/** 用户ID */
@property (nonatomic, copy) NSString *exchange_status;
/** 链接 */
@property (nonatomic, copy) NSString *shop_name;
/** 属性组合 */
@property (nonatomic, copy) NSString *car_id;
/** 商品图片 */
@property (nonatomic, copy) NSString *goods_content;
/** 所属商家名 */
@property (nonatomic, copy) NSString *gifi_note;
/** 金额小计 */
@property (nonatomic, copy) NSString *user_id;
/** 属性id */
@property (nonatomic, copy) NSString *market_price;
/** 添加时间 */
@property (nonatomic, copy) NSString *goods_name;
/** 购物车id */
@property (nonatomic, copy) NSString *xzmoney;
/** 商品id */
@property (nonatomic, copy) NSString *cat_id;
/** 用户ID */
@property (nonatomic, copy) NSString *shop_price;
/** 链接 */
@property (nonatomic, copy) NSString *postage;
/** 属性组合 */
@property (nonatomic, copy) NSString *brand_id;
/** 商品图片 */
@property (nonatomic, copy) NSString *goods_img;
/** 所属商家名 */
@property (nonatomic, copy) NSString *goods_kucun;
/** 金额小计 */
@property (nonatomic, copy) NSString *addtime;
/** 属性id */
@property (nonatomic, copy) NSString *num;
/** 添加时间 */
@property (nonatomic, copy) NSString *add_time;
/** 购物车id */
@property (nonatomic, copy) NSString *goods_id;
/** 所属商家名 */
@property (nonatomic, copy) NSString *attr_id;
/** 金额小计 */
@property (nonatomic, copy) NSString *is_best;
/** 属性id */
@property (nonatomic, copy) NSString *click_num;
/** 添加时间 */
@property (nonatomic, copy) NSString *goods_sn;
/** 购物车id */
@property (nonatomic, copy) NSString *shop_id;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isCalculateViewHidden;

@end
