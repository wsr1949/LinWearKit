//
//  LWPoiCheckInModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWPoiCheckInModel : NSObject

/// 打卡时间戳
@property (nonatomic, assign) NSInteger timestamp;

/// 纬度
@property (nonatomic, assign) double latitude;

/// 经度
@property (nonatomic, assign) double longitude;

@end

NS_ASSUME_NONNULL_END
