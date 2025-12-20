//
//  LWBaseViewController.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWBaseViewController : UIViewController

/// 添加单个导航栏右按钮
- (void)addRightBarButtonItem:(NSString *)title itemEvent:(void(^)(void))itemEvent;

/// 安全区域
- (UIEdgeInsets)safeAreaInsets;

@end

NS_ASSUME_NONNULL_END
