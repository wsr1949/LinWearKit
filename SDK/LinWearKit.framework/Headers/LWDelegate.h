//
//  LWDelegate.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-16.
//

#ifndef LWDelegate_h
#define LWDelegate_h


/// 委托代理
@protocol LWDelegate <NSObject>

@required

/**
 中心蓝牙状态
 @param status                  蓝牙状态
 */
- (void)centralBluetoothStatus:(CBManagerState)status;


/**
 发现外围设备
 @param peripheralModel         设备信息
 */
- (void)discoverPeripheral:(LWPeripheralModel * _Nonnull)peripheralModel;


/**
 BLE连接状态
 @param status                  ble状态
 @param error                   错误
 */
- (void)bleConnectionStatus:(LWBleStatus)status error:(NSError * _Nullable)error;


@optional

/**
 SDK日志，enableLog需要设置开启
 @param logText                 日志
 */
- (void)outputSdkLog:(NSString * _Nullable)logText;


/**
 设备开始录音
 @param function                录音的功能类型
 */
- (void)deviceDidStartAudioRecordingWithFunction:(LWAudioFunction)function;


/**
 设备录音数据
 @param audioData               音频数据
 @param audioFormat             音频格式
 */
- (void)deviceAudioRecordingWithAudioData:(NSData * _Nonnull)audioData audioFormat:(LWAudioFormat)audioFormat;


/**
 设备结束录音
 */
- (void)deviceDidEndAudioRecording;


/**
 宠物状态更新
 @param aipetStatusModel        宠物状态
 */
- (void)aiPetStatusUpdateWithModel:(LWAipetStatusModel * _Nonnull)aipetStatusModel;


/**
 撸宠动作更新
 @param aipetActionModel        宠物动作
 */
- (void)aiPetActionUpdateWithModel:(LWAipetActionModel * _Nonnull)aipetActionModel;


/**
 设备开始POI打卡
 @param timeOut                 打卡超时时间
 */
- (void)deviceDidStartPoiCheckInWithTimeOut:(NSInteger)timeOut;


/**
 设备POI打卡更新
 @param poiCheckInModel         打卡信息
 */
- (void)devicePoiCheckInUpdateWithModel:(LWPoiCheckInModel * _Nonnull)poiCheckInModel;


@end

#endif /* LWDelegate_h */
