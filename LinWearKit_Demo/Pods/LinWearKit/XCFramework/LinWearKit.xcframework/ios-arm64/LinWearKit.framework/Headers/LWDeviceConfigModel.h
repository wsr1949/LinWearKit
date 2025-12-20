//
//  LWDeviceConfigModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWDeviceConfigModel : NSObject

/// 设备名称
@property(nonatomic, copy) NSString *deviceName;

/// 设备MAC地址
@property(nonatomic, copy) NSString *deviceMac;

/// 设备适配号
@property(nonatomic, copy) NSString *deviceMode;

/// 设备固件版本号
@property(nonatomic, copy) NSString *deviceFwVersion;

/// 设备UI版本号
@property(nonatomic, copy) NSString *deviceUiVersion;

/// 设备ID
@property(nonatomic, assign) uint32_t deviceId;

/// 设备序列号SN
@property(nonatomic, copy) NSString *deviceSn;

/// 设备显示屏分辨率
@property(nonatomic, assign) CGSize deviceRes;

/// 设备显示屏形状
@property(nonatomic, assign) LWScreenShape deviceShape;

@end

NS_ASSUME_NONNULL_END
