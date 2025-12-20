//
//  LWHolidayAnimationModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHolidayAnimationModel : NSObject

/// 节日月份
@property (nonatomic, assign) int month;

/// 节日日期
@property (nonatomic, assign) int day;

/// 前景动画编号
@property (nonatomic, assign) NSInteger foreground;

/// 背景动画编号
@property (nonatomic, assign) NSInteger background;

/// 背景细节动画编号
@property (nonatomic, assign) NSInteger background_detail;

@end

NS_ASSUME_NONNULL_END
