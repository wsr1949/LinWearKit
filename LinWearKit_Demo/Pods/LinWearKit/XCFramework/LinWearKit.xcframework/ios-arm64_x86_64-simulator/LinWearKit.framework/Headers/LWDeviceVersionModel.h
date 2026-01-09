//
//  LWDeviceVersionModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-01-08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWDeviceVersionModel : NSObject

/// 设备固件版本号
@property(nonatomic, copy) NSString *deviceFwVersion;

/// 设备资源版本号
@property(nonatomic, copy) NSString *deviceResVersion;

/// 离线语音语种，0表示en 1表示zh
@property(nonatomic, assign) int vadLanguage;

/// 离线语音是否授权，YES已授权 NO未授权
@property(nonatomic, assign) BOOL vadAuthorize;

@end

NS_ASSUME_NONNULL_END
