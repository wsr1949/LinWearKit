![LOGO](https://github.com/wsr1949/LinWearKit/blob/main/Resources/000.png)

<p align="left">

<a href="https://github.com/wsr1949/LinWearKit.git">
    <img src="https://img.shields.io/badge/Release-1.0.1 -Green.svg">
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
 @param audioData               音频数据
 @param audioFormat             音频格式
 */
- (void)deviceAudioRecordingWithAudioData:(NSData * _Nonnull)audioData audioFormat:(LWAudioFormat)audioFormat;
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
 */
- (void)deviceDidStartPoiCheckInWithTimeOut:(NSInteger)timeOut;
```

##### 设备POI打卡更新
```ruby
/**
 设备POI打卡更新
 @param poiCheckInModel         打卡信息
 */
- (void)devicePoiCheckInUpdateWithModel:(LWPoiCheckInModel * _Nonnull)poiCheckInModel;
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

##### 获取设备配置信息
```ruby
/**
 获取设备配置信息
 @param callback                object设备配置信息
 */
+ (void)getDeviceConfigInfoWithCallback:(LWResultDeviceConfigCallback)callback;
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


- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -


# 版本记录🚀
```ruby
 project    2025-12-29  Version:1.0.1   Build:2025122901
            1.新增请求离线语音授权码 参@link requestOfflineVoiceAuthCodeWithMac:withLang:withCallback:

 project    2025-12-20  Version:1.0.0   Build:2025122001
            1.首版
```
