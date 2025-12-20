//
//  UIButton+Expand.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "UIButton+Expand.h"

@implementation UIButton (Expand)

/// 添加按钮点击响应事件
- (void)addActionCallback:(void (^)(void))callback
{
    [self addAction:[UIAction actionWithHandler:^(__kindof UIAction * _Nonnull action) {
        GCD_MAIN_QUEUE(^{
            if (callback) callback();
        });
    }] forControlEvents:UIControlEventTouchUpInside];
}

@end
