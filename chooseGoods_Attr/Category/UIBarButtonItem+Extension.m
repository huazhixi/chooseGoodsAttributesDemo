//
//  UIBarButtonItem+Extension.m
//  灵秀微博
//
//  Created by LingXiu on 15/7/8.
//  Copyright (c) 2015年 LingXiu. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "YYCategories.h"
#import "GlobalDefine.h"

@implementation UIBarButtonItem (Extension)
/**
 *  设置 只带 文字 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action name:(NSString *)name
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:name forState:UIControlStateNormal];
    [btn setTitleColor:kWhiteColor forState:UIControlStateNormal];
//    [btn setTitleColor:LXBrownColor forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    // 设置尺寸
    btn.size = CGSizeMake(50, 30);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
    
}
/**
 *  设置 只带 图片 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
//    btn.size = btn.currentBackgroundImage.size;
    btn.size = CGSizeMake(20, 20);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
/**
 *  设置 带 图片和文字 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor grayColor];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    // 设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 30);
    // 设置尺寸
    btn.size = CGSizeMake(40, 40);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  设置 只带 图片 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage size:(CGSize)size
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //    btn.size = btn.currentBackgroundImage.size;
    btn.size = size;
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end
