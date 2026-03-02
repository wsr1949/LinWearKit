![LOGO](https://github.com/wsr1949/LinWearKit/blob/main/Resources/000.png)

<p align="left">

<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/Release-1.0.6 -Green.svg">
</a>
<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/Support-iOS14.0+ -blue.svg">
</a>
<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/Support-CocoaPods -aquamarine.svg">
</a>
<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/Language-Objective_C -red.svg">
</a>
<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/License-MIT -gold.svg">
</a>

</p>


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# 🧬LinWearKit

#### LinWearKit 为智能设备的iOS框架，负责与智能设备通信等功能的封装。

## 兼容性（XCFramework）

#### 支持 `iOS 14.0 及以上操作系统`

### [⚠️请仔细阅读 `README` 集成SDK；参考提供的示例 `Demo`，以帮助您更好地理解 `API` 的使用！](#NOTE)


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


## 一、安装（CocoaPods）

##### 1. 在 `Podfile` 中添加
```ruby
pod 'LinWearKit', git: 'https://github.com/wsr1949/LinWearKit.git'
```

##### 2. 终端执行 
```ruby
pod install
```

## 二、Info.plist 添加隐私权限描述

##### 1. 蓝牙权限
```objective-c
Privacy - Bluetooth Always Usage Description
```

![001](https://github.com/wsr1949/LinWearKit/blob/main/Resources/001.png)

## 三、TARGRTS 添加 Capability

##### 1. 后台模式 `Background Modes` 勾选
```objective-c 
Uses Bluetooth LE accessories
```

![002](https://github.com/wsr1949/LinWearKit/blob/main/Resources/002.png)


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# 🎉开始使用

## 一、导入头文件
```objective-c 
#import <LinWearKit/LinWearKit.h>
```

## 二、初始化SDK（详阅LinWearKit.h）注册委托代理

##### 初始化，注册委托代理
```ruby 
/**
 初始化，注册委托代理
 @param delegate                委托代理
 @param enableLog               是否开启日志输出 详@link 【LDelegate】outputSdkLog:
 */
+ (void)registerDelegate:(id <LWDelegate> _Nonnull)delegate enableLog:(BOOL)enableLog;
```

## 三、实现委托代理方法

##### 中心蓝牙状态
```ruby
/**
 中心蓝牙状态
 @param status                  蓝牙状态
 */
- (void)centralBluetoothStatus:(CBManagerState)status;
```

##### 发现外围设备
```ruby
/**
 发现外围设备
 @param peripheralModel         设备信息
 */
- (void)discoverPeripheral:(LWPeripheralModel * _Nonnull)peripheralModel;
```

##### BLE连接状态
```ruby
/**
 BLE连接状态
 @param status                  ble状态
 @param error                   错误
 */
- (void)bleConnectionStatus:(LWBleStatus)status error:(NSError * _Nullable)error;
```

##### SDK日志，enableLog需要设置开启
```ruby
/**
 SDK日志，enableLog需要设置开启
 @param logText                 日志
 */
- (void)outputSdkLog:(NSString * _Nullable)logText;
```

##### 设备开始录音
```ruby
/**
 设备开始录音
 @param function                录音的功能类型
 */
- (void)deviceDidStartAudioRecordingWithFunction:(LWAudioFunction)function;
```

##### 设备录音数据
```ruby
/**
 设备录音数据
 @param dataArray               音频数据数组
 @param audioFormat             音频格式
 */
- (void)deviceAudioRecordingWithDataArray:(NSArray <NSData *> * _Nonnull)dataArray audioFormat:(LWAudioFormat)audioFormat;
```

##### 设备结束录音
```ruby
/**
 设备结束录音
 */
- (void)deviceDidEndAudioRecording;
```

##### 宠物状态更新
```ruby
/**
 宠物状态更新
 @param aipetStatusModel        宠物状态
 */
- (void)aiPetStatusUpdateWithModel:(LWAipetStatusModel * _Nonnull)aipetStatusModel;
```

##### 撸宠动作更新
```ruby
/**
 撸宠动作更新
 @param aipetActionModel        宠物动作
 */
- (void)aiPetActionUpdateWithModel:(LWAipetActionModel * _Nonnull)aipetActionModel;
```

##### 设备开始POI打卡
```ruby
/**
 设备开始POI打卡
 @param timeOut                 打卡超时时间
 @param type                    打卡类型
 @param device                  双人打卡时，对端设备
 */
- (void)deviceDidStartPoiCheckInWithTimeOut:(NSInteger)timeOut type:(LWPoiCheckInType)type device:(NSString * _Nullable)device;
```

##### 设备POI打卡更新
```ruby
/**
 设备POI打卡更新
 @param poiCheckInModel         打卡信息
 */
- (void)devicePoiCheckInUpdateWithModel:(LWPoiCheckInModel * _Nonnull)poiCheckInModel;
```

##### 设备资源缺失
```ruby
/**
 设备资源缺失
 @param resourcesModel          设备资源信息
 */
- (void)deviceResourcesMissingWithModel:(LWDeviceResourcesModel * _Nonnull)resourcesModel;
```

##### 设备发起交互
```ruby
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
```

## 四、命令方法

##### 开始扫描设备
```ruby
/**
 开始扫描设备
 */
+ (void)startScanning;
```

##### 停止扫描设备
```ruby
/**
 停止扫描设备
 */
+ (void)stopScanning;
```

##### 连接设备
```ruby
/**
 连接设备
 @param uuid                    设备UUID
 @param timeout                 连接超时时间（设置0则忽略超时）秒
 @note  连接结果 详@link 【LDelegate】bleConnectionStatus:error:
 */
+ (void)connectingDevice:(NSString * _Nonnull)uuid timeout:(int)timeout;
```

##### 断开设备连接
```ruby
/**
 断开设备连接
 */
+ (void)disconnectDevice;
```

##### 中心蓝牙状态
```ruby
/**
 中心蓝牙状态
 @return    中心蓝牙状态
*/
+ (CBManagerState)centralManagerState;
```

##### BLE连接状态
```ruby
/**
 BLE连接状态
 @return    BLE连接状态
 */
+ (LWBleStatus)bleStatus;
```

##### 设置设备系统类型（iOS）
```ruby
/**
 设置设备系统类型（iOS）
 @note  ⚠️重要：每次连接成功都必须设置
 */
+ (void)setDeviceSystemTypeWithCallback:(LWResultCallback)callback;
```

##### 设置设备系统时间
```ruby
/**
 设置设备系统时间
 @note  ⚠️跟随本地系统时间
 */
+ (void)setDeviceSystemTimeWithCallback:(LWResultCallback)callback;
```

##### 设置设备系统语言
```ruby
/**
 设置设备系统语言
 @param language                语言类型
 */
+ (void)setDeviceSystemLanguage:(LWLanguageType)language withCallback:(LWResultCallback)callback;
```

##### 设置设备系统音量
```ruby
/**
 设置设备系统音量
 @param volume                  音量值（0-16）
 */
+ (void)setDeviceSystemVolume:(int)volume withCallback:(LWResultCallback)callback;
```

##### 获取设备系统音量
```ruby
/**
 获取设备系统音量
 @param callback                number数值：音量值
 */
+ (void)getDeviceSystemVolumeWithCallback:(LWResultNumberCallback)callback;
```

##### 设置设备屏幕亮度
```ruby
/**
 设置设备屏幕亮度
 @param brightness              亮度值：0-100
 */
+ (void)setDeviceScreenBrightness:(int)brightness withCallback:(LWResultCallback)callback;
```

##### 获取设备屏幕亮度
```ruby
/**
 获取设备屏幕亮度
 @param callback                number数值：亮度值
 */
+ (void)getDeviceScreenBrightnessWithCallback:(LWResultNumberCallback)callback;
```

#### 绑定宠物
```ruby
/**
 绑定宠物
 @param identifier              绑定标识符
 @param callback                number数值：0表示绑定成功，其他则表示失败
 */
+ (void)bindAipetWithIdentifier:(NSString * _Nonnull)identifier withCallback:(LWResultNumberCallback)callback;
```

##### 解绑宠物
```ruby
/**
 解绑宠物
 @param identifier              解绑标识符
 @param callback                number数值：0表示解绑成功，其他则表示失败
 */
+ (void)unbindAipetWithIdentifier:(NSString * _Nonnull)identifier withCallback:(LWResultNumberCallback)callback;
```

##### 获取宠物状态
```ruby
/**
 获取宠物状态
 @param callback                object宠物状态
 */
+ (void)getAipetStatusWithCallback:(LWResultAipetStatusCallback)callback;
```

##### 设置宠物进化
```ruby
/**
 设置宠物进化
 @param evolvedModel            进化信息
 @param callback                number数值：0表示进化成功，其他则表示失败
 */
+ (void)setEvolvedAipetWithModel:(LWAipetEvolvedModel * _Nonnull)evolvedModel withCallback:(LWResultNumberCallback)callback;
```

##### 设置宠物奖励
```ruby
/**
 设置宠物奖励
 @param aipetReward             奖励信息
 @param callback                number数值：0表示奖励成功，其他则表示失败
 */
+ (void)setAipetRewardWithModel:(LWAipetRewardModel * _Nonnull)aipetReward withCallback:(LWResultCallback)callback;
```

##### 设置今天天气
```ruby
/**
 设置今天天气
 @param weatherModel            天气信息
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setTodayWeatherWithModel:(LWTodayWeatherModel * _Nonnull)weatherModel withCallback:(LWResultNumberCallback)callback;
```

##### 设置小时天气
```ruby
/**
 设置小时天气
 @param weatherModel            天气信息
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setHourWeatherWithModel:(LWHourWeatherModel * _Nonnull)weatherModel withCallback:(LWResultNumberCallback)callback;
```

##### 添加新动画
```ruby
/**
 添加新动画
 @param animationModel          动画信息
 @param callback                number数值：0表示添加成功，其他则表示失败
 */
+ (void)addNewAnimationWithModel:(LWAnimationModel * _Nonnull)animationModel withCallback:(LWResultNumberCallback)callback;
```

##### 设置设备停止录音
```ruby
/**
 设置设备停止录音
 */
+ (void)setDeviceStopAudioRecordingWithCallback:(LWResultCallback)callback;
```

##### opus转pcm（音频流数据）
```ruby
/**
 opus转pcm（音频流数据）
 @param opus                    opus音频流数据
 @return                        成功则返回pcm音频流数据，失败为nil
 */
+ (NSData * _Nullable)opusStream2pcm:(NSArray <NSData *> * _Nonnull)opus;
```

##### opus转ogg（音频流数据）
```ruby
/**
 opus转ogg（音频流数据）
 @param opus                    opus音频流数据
 @return                        成功则返回ogg音频流数据，失败为nil
 */
+ (NSData * _Nullable)opusStream2ogg:(NSArray <NSData *> * _Nonnull)opus;
```

##### 设置车载模式
```ruby
/**
 设置车载模式
 @param open                    车载模式：YES表示开启，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setCarMode:(BOOL)open withCallback:(LWResultNumberCallback)callback;
```

##### 获取车载模式
```ruby
/**
 获取车载模式
 @param callback                number数值：0表示关闭，1表示开启
 */
+ (void)getCarModeWithCallback:(LWResultNumberCallback)callback;
```

##### 从服务器请求离线语音授权码
```ruby
/**
 从服务器请求离线语音授权码
 @param mac                     设备Mac地址
 @param lang                    离线语音语种简写：如英文en
 */
+ (void)requestOfflineVoiceAuthCodeWithMac:(NSString * _Nonnull)mac withLang:(NSString * _Nonnull)lang withCallback:(LWResultOfflineVoiceAuthCodeCallback)callback;
```

##### 设置离线语音授权码
```ruby
/**
 设置离线语音授权码
 @param authorizeCode           授权码
 @param callback                number数值：0表示授权成功，其他则表示失败
 */
+ (void)setOfflineVoiceAuthorizeCode:(NSString * _Nonnull)authorizeCode withCallback:(LWResultNumberCallback)callback;
```

##### 设置节日动画
```ruby
/**
 设置节日动画
 @param holidayAnimationModel   节日动画
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setHolidayAnimationWithModel:(LWHolidayAnimationModel * _Nonnull)holidayAnimationModel withCallback:(LWResultNumberCallback)callback;
```

##### 设置设备地区
```ruby
/**
 设置设备地区
 @param areaCode                地区编号
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDeviceAreaCode:(NSInteger)areaCode withCallback:(LWResultNumberCallback)callback;
```

##### 设置AI对话语音情绪
```ruby
/**
 设置AI对话语音情绪
 @param moodCode                情绪编号
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setAiDialogueVoiceMoodCode:(NSInteger)moodCode withCallback:(LWResultNumberCallback)callback;
```

##### 从服务器请求星历文件
```ruby
/**
 从服务器请求星历文件
 */
+ (void)requestEphemerisFileWithCallback:(LWResultEphemerisCallback)callback;
```

##### 文件上传协商
```ruby
/**
 文件上传协商
 @param negotModel              文件协商信息
 @note  ⚠️先调用此API协商，根据结果再开始上传文件 详@link startUploadingFilesWithModel:withProgressCallback:withResultCallback:
 */
+ (void)fileUploadNegotiationWithModel:(LWUploadFileNegotModel * _Nonnull)negotModel withCallback:(LWResultUploadNegotCallback)callback;
```

##### 开始上传文件
```ruby
/**
 开始上传文件
 @param uploadFileModel         文件上传信息
 @param progressCallback        上传进度回调，progress进度0-100
 @param callback                文件上传结果，error为nil时表示成功
 @note  ⚠️调用此API之前，需要先协商 详@link fileUploadNegotiationWithModel:withCallback:
 */
+ (void)startUploadingFilesWithModel:(LWUploadFileModel * _Nonnull)uploadFileModel withProgressCallback:(LWResultProgressCallback)progressCallback withCallback:(LWResultCallback)callback;
```

##### 设备AI语音播放控制
```ruby
/**
 设备AI语音播放控制
 @param play                    播放控制，YES表示开始播放，NO表示结束播放
 */
+ (void)deviceAiVoicePlaybackControl:(BOOL)play withCallback:(LWResultCallback)callback;
```

##### 获取设备版本信息
```ruby
/**
 获取设备版本信息
 @param callback                object设备版本信息
 */
+ (void)getDeviceVersionInfoWithCallback:(LWResultDeviceVersionCallback)callback;
```

##### 设置KWS命令词开关状态
```ruby
/**
 设置KWS命令词开关状态
 @param code                    KWS命令词编号
 @param status                  开关状态，YES表示打开，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setKWSCommandWord:(NSInteger)code status:(BOOL)status withCallback:(LWResultNumberCallback)callback;
```

##### 设置POI打卡地列表
```ruby
/**
 设置POI打卡地列表
 @param list                    POI打卡地信息
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setPoiCheckInSpotsWithList:(NSArray <LWCheckInSpotsModel *> * _Nonnull)list withCallback:(LWResultCheckInSpotsCallback)callback;
```

##### 设置勿扰模式
```ruby
/**
 设置勿扰模式
 @param mode                    勿扰开关，YES表示打开，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDoNotDisturbMode:(BOOL)mode withCallback:(LWResultNumberCallback)callback;
```

##### 获取勿扰模式
```ruby
/**
 获取勿扰模式
 @param callback                number数值：0表示关闭，1表示开启
 */
+ (void)getDoNotDisturbModeWithCallback:(LWResultNumberCallback)callback;
```

##### 设置设备A2DP连接
```ruby
/**
 设置设备A2DP连接
 @param connect                 事件，YES表示连接A2DP，NO表示断开A2DP
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDeviceA2DPConnection:(BOOL)connect withCallback:(LWResultNumberCallback)callback;
```

##### 响应设备交互
```ruby
/**
 响应设备交互
 @param error_code              错误码，0表示响应成功，其他则表示失败
 */
+ (void)respondDeviceInteraction:(NSInteger)error_code withCallback:(LWResultCallback)callback;
```

##### 调试模式命令
```ruby
/**
 调试模式命令
 */
+ (void)debugModeWithCommand:(LWDebugModeCommand)command withCallback:(LWResultCallback)callback;
```

- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# 版本记录🚀
```ruby
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
```
