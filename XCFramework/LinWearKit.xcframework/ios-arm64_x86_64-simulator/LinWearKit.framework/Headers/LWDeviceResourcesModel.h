//
//  LWDeviceResourcesModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-01-08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWDeviceResourcesModel : NSObject

/// 设备资源版本号
@property(nonatomic, copy) NSString *deviceResVersion;

/// 设备资源名称
@property(nonatomic, copy) NSString *deviceResName;

/// 设备资源编号
@property(nonatomic, assign) NSInteger deviceResCode;

@end

NS_ASSUME_NONNULL_END
