//
//  LWHeader.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-16.
//

#ifndef LWHeader_h
#define LWHeader_h

/**
 框架名称：LinWearKit.xcframework
 框架功能：智能设备的iOS框架，负责与智能设备通信等功能的封装。
                             
 GitHub @link https://github.com/wsr1949/LinWearKit.git
 
 版本记录：
 
 project    2026-03-05  Version:1.0.7   Build:2026030501
            1.新增「初始化音频格式（开始）」方法 参@link initAudioFormat:withCallback:
            2.新增「初始化音频元信息」方法 参@link initAudioMeta:withCallback:
            3.新增「发送音频数据」方法 参@link sendAudioData:withCallback:
            4.新增「音频数据发送完成，请求校验文件」方法 参@link requestVerifyAudioData:streamId:fileId:withCallback:
            5.新增「响应发送的音频总数量（结束）」方法 参@link respondSentAudioCount:streamId:withCallback:
            6.新增「响应当前APP状态」方法 参@link respondCurrentAppStates:withCallback:
            7.新增「设备屏幕状态」委托代理方法 参@link deviceScreenStatus:
            8.新增「设备请求APP状态」委托代理方法 参@link deviceRequestsAppStatus
 
 project    2026-02-25  Version:1.0.6   Build:2026022501
            1.更新「设备录音数据」委托代理方法，方法由 deviceAudioRecordingWithAudioData:audioFormat: 改为 参@link LWDelegate deviceAudioRecordingWithDataArray:audioFormat:
            2.新增「opus转pcm」方法 参@link opusStream2pcm:
            3.新增「opus转ogg」方法 参@link opusStream2ogg:
 
 project    2026-02-06  Version:1.0.5   Build:2026020601
            1.更新「交互类型」枚举 参@link LWInteractionType枚举
            2.更新「设置小时天气」方法，入参为数组 参@link setHourWeatherWithLists:withCallback:
            3.新增「设置设备执行动画命令」方法 参@link setDeviceExecutionAnimationWithCommand:withCallback:
            4.新增「设备取消AI对话」委托代理方法 参@link LWDelegate deviceCancelsAiDialogue
            5.新增「设备BR连接配对状态」委托代理方法 参@link LWDelegate deviceBrConnectionPairingStatus:
            6.更新「文件上传协商」新增文件名称filePath参数，具体使用见注释 参@link LWUploadFileNegotModel
            7.新增「资源文件diff更新协商」方法 参@link resourceFileDiffUpdateNegotiationWithSize:withCallback:
            8.新增「删除设备文件或目录」方法 参@link deleteDeviceFilesOrDirectories::withCallback:
 
 project    2026-01-22  Version:1.0.4   Build:2026012201
            1.新增「设备POI打卡地更新」委托代理方法 参@link LWDelegate devicePoiCheckInSpotsUpdateWithModel:
            2.更新「设置POI打卡地列表」方法，打卡地更新结果通过委托代理返回 参@link LWDelegate devicePoiCheckInSpotsUpdateWithModel:
            3.新增「固件」类型文件上传 参@link LWFileType枚举
 
 project    2026-01-21  Version:1.0.3   Build:2026012101
            1.更新pb协议文件
 
 project    2026-01-08  Version:1.0.2   Build:2026010801
            1.更新「设备开始POI打卡」委托代理方法，增加打卡类型和对端设备信息 参@link LWDelegate deviceDidStartPoiCheckInWithTimeOut...
            2.新增「设备资源缺失」委托代理方法 参@link LWDelegate deviceResourcesMissingWithModel:
            3.移除「抽奖动画编号」参数 参@link LWAipetRewardModel
            3.更新「设置节日动画」方法，增加'交互音频编号'参数 参@link LWHolidayAnimationModel
            4.新增「设置设备屏幕亮度」方法 参@link setDeviceScreenBrightness:withCallback:
            5.新增「获取设备屏幕亮度」方法 参@link getDeviceScreenBrightnessWithCallback:
            6.新增「设备AI语音播放控制」方法 参@link deviceAiVoicePlaybackControl:withCallback:
            7.移除「获取设备配置信息」方法
            8.新增「获取设备版本信息」方法 参@link getDeviceVersionInfoWithCallback:
            9.新增「设置KWS命令词开关状态」方法 参@link setKWSCommandWord:withCallback:
            10.新增「设置POI打卡地列表」方法 参@link setPoiCheckInSpotsWithList:withCallback:
            11.新增「设置勿扰模式」方法 参@link setDoNotDisturbMode:withCallback:
            12.新增「获取勿扰模式」方法 参@link getDoNotDisturbModeWithCallback:
            13.新增「设备发起交互」委托代理方法 参@link LWDelegate deviceInitiatesInteractionWithType:latitude:longitude:
            14.新增「设置设备A2DP连接」方法 参@link setDeviceA2DPConnection:withCallback:
            15.新增「响应设备交互」方法 参@link respondDeviceInteraction:withCallback:
            16.新增「调试模式命令」方法 参@link debugModeWithCommand:withCallback:
 
 project    2025-12-29  Version:1.0.1   Build:2025122901
            1.新增请求离线语音授权码 参@link requestOfflineVoiceAuthCodeWithMac:withLang:withCallback:
 
 project    2025-12-20  Version:1.0.0   Build:2025122001
            1.首版
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import <LinWearKit/LWMacro.h>

#import <LinWearKit/LWPeripheralModel.h>
#import <LinWearKit/LWAipetStatusModel.h>
#import <LinWearKit/LWAipetActionModel.h>
#import <LinWearKit/LWAipetEvolvedModel.h>
#import <LinWearKit/LWPoiCheckInModel.h>
#import <LinWearKit/LWAipetRewardModel.h>
#import <LinWearKit/LWTodayWeatherModel.h>
#import <LinWearKit/LWHourWeatherModel.h>
#import <LinWearKit/LWAnimationModel.h>
#import <LinWearKit/LWHolidayAnimationModel.h>
#import <LinWearKit/LWUploadFileModel.h>
#import <LinWearKit/LWUploadFileNegotModel.h>
#import <LinWearKit/LWUploadNegotModel.h>
#import <LinWearKit/LWDeviceVersionModel.h>
#import <LinWearKit/LWDeviceResourcesModel.h>
#import <LinWearKit/LWCheckInSpotsModel.h>
#import <LinWearKit/LWCheckInSpotsResultModel.h>
#import <LinWearKit/LWAudioFormatModel.h>
#import <LinWearKit/LWAudioMetaModel.h>

#import <LinWearKit/LWDelegate.h>
#import <LinWearKit/LWCallback.h>

#endif /* LWHeader_h */
