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
 @param dataArray               音频数据数组
 @param audioFormat             音频格式
 */
- (void)deviceAudioRecordingWithDataArray:(NSArray <NSData *> * _Nonnull)dataArray audioFormat:(LWAudioFormat)audioFormat;


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
 @param type                    打卡类型
 @param device                  双人打卡时，对端设备
 */
- (void)deviceDidStartPoiCheckInWithTimeOut:(NSInteger)timeOut type:(LWPoiCheckInType)type device:(NSString * _Nullable)device;


/**
 设备POI打卡更新
 @param poiCheckInModel         打卡信息
 */
- (void)devicePoiCheckInUpdateWithModel:(LWPoiCheckInModel * _Nonnull)poiCheckInModel;


/**
 设备资源缺失
 @param resourcesModel          设备资源信息
 */
- (void)deviceResourcesMissingWithModel:(LWDeviceResourcesModel * _Nonnull)resourcesModel;


/**
 设备发起交互
 @param interactionType         交互类型
 @param latitude                纬度，当为Poi类型时返回
 @param longitude               经度，当为Poi类型时返回
 
 @note  当TTS生成后需要播放时，为确保音频和动画一致性，成功响应交互后再播放TTS
        1. 先设置连接A2DP 详@link 【LinWearKit】setDeviceA2DPConnection:withCallback:
        2. A2DP连接成功后再响应交互 详@link 【LinWearKit】respondDeviceInteraction:withCallback:
 */
- (void)deviceInitiatesInteractionWithType:(LWInteractionType)interactionType latitude:(double)latitude longitude:(double)longitude;


/**
 设备POI打卡地更新
 @param checkInSpotsModel       打卡地信息，其中error_code为0表示设置成功，其他则表示失败
 */
- (void)devicePoiCheckInSpotsUpdateWithModel:(LWCheckInSpotsResultModel * _Nonnull)checkInSpotsModel;


/**
 设备取消AI对话
 */
- (void)deviceCancelsAiDialogue;


/**
 设备BR连接配对状态
 */
- (void)deviceBrConnectionPairingStatus:(LWPairingStatus)status;

@end

#endif /* LWDelegate_h */
