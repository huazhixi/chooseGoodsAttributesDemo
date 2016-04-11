//
//  GlobalDefine.h
//  chooseGoods_Attr
//
//  Created by Lingxiu on 16/4/6.
//  Copyright © 2016年 Lingxiu. All rights reserved.
//

#ifndef GlobalDefine_h
#define GlobalDefine_h


#define SERVERURL  @"your http_url"

#define kSmallMargin 10
#define kBigMargin 20

#define kATTR_VIEW_HEIGHT kScreenH * 0.7
#define kContentTextFont   [UIFont systemFontOfSize:15]
#define kButtonTextFont   [UIFont systemFontOfSize:13]
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

// RGB颜色
#define HX_RGB(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 主题颜色
#define kMAINCOLOR [[UIColor alloc]initWithRed:250/255.0 green:54/255.0 blue:103/255.0 alpha:1]
// 点击渐变颜色
#define kMaterial_MAINCOLOR [[UIColor alloc]initWithRed:250/255.0 green:54/255.0 blue:103/255.0 alpha:0.5]

// 背景灰
#define kBACKCOLOR [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0]
/**
 *  白色
 */
#define kWhiteColor [UIColor whiteColor]
/**
 *  红色
 */
#define kRedColor [UIColor redColor]
/**
 *  黑色
 */
#define kBlackColor [UIColor blackColor]
/**
 *  border颜色
 */
#define LXBorderColor [UIColor colorWithRed:(225)/255.0 green:(225)/255.0 blue:(225)/255.0 alpha:1.0]


#endif /* GlobalDefine_h */