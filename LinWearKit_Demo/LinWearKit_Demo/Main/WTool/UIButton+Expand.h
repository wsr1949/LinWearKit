//
//  UIButton+Expand.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (Expand)

/// 添加按钮点击响应事件
- (void)addActionCallback:(void (^)(void))callback;

@end

NS_ASSUME_NONNULL_END
