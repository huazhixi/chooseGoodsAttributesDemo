//
//  UIBarButtonItem+Extension.h
//  灵秀微博
//
//  Created by LingXiu on 15/7/8.
//  Copyright (c) 2015年 LingXiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
/**
 *  设置 只带 文字 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action name:(NSString *)name;
/**
 *  设置 只带 图片 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;
/**
 *  设置 带 图片和文字 的barItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage title:(NSString *)title;
/**
 *  设置 只带 图片 的barItem,且自定义大小
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage size:(CGSize)size;
@end
