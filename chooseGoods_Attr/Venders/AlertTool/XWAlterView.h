//
//  XWAlterVeiw.h
//  XWAleratView
//
//  Created by 温仲斌 on 15/12/25.
//  Copyright © 2015年 温仲斌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XWAlterView : UIView

@property (nonatomic, copy) void (^textBlock)(NSString *text);

- (void)show;
@end
