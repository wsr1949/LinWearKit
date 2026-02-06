//
//  LWHourWeatherModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWHourWeatherModel : NSObject

/// 小时整点
@property (nonatomic, assign) int hour;

/// 天气编码
@property (nonatomic, assign) NSInteger weatherCode;

@end

NS_ASSUME_NONNULL_END
