//
//  LWCallback.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-16.
//

#ifndef LWCallback_h
#define LWCallback_h

/**
 结果回调
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultCallback)(NSError * _Nullable error);


/**
 数值结果回调
 @param number              业务数值
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultNumberCallback)(NSNumber * _Nullable number, NSError * _Nullable error);


/**
 设备配置信息结果回调
 @param object              设备配置信息
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultDeviceConfigCallback)(LWDeviceConfigModel * _Nullable object, NSError * _Nullable error);


/**
 宠物状态结果回调
 @param object              宠物状态
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultAipetStatusCallback)(LWAipetStatusModel * _Nullable object, NSError * _Nullable error);


/**
 进度结果回调
 @param progress            进度0-100
 */
typedef void(^LWResultProgressCallback)(int progress);


/**
 星历文件信息回调
 @param object              星历文件本地路径
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultEphemerisCallback)(NSString * _Nullable object, NSError * _Nullable error);


/**
 文件上传协商结果回调
 @param object              协商结果
 @param error               错误信息，为nil时表示成功
 */
typedef void(^LWResultUploadNegotCallback)(LWUploadNegotModel * _Nullable object, NSError * _Nullable error);


#endif /* LWCallback_h */
