//
//  LinWearKit.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-16.
//

#import <Foundation/Foundation.h>
/// 更新记录、公开头文件
#import <LinWearKit/LWHeader.h>

NS_ASSUME_NONNULL_BEGIN

@interface LinWearKit : NSObject

/**
 初始化，注册委托代理
 @param delegate                委托代理
 @param enableLog               是否开启日志输出 详@link 【LDelegate】outputSdkLog:
 */
+ (void)registerDelegate:(id <LWDelegate> _Nonnull)delegate enableLog:(BOOL)enableLog;


/**
 开始扫描设备
 */
+ (void)startScanning;


/**
 停止扫描设备
 */
+ (void)stopScanning;


/**
 连接设备
 @param uuid                    设备UUID
 @param timeout                 连接超时时间（设置0则忽略超时）秒
 @note  连接结果 详@link 【LDelegate】bleConnectionStatus:error:
 */
+ (void)connectingDevice:(NSString * _Nonnull)uuid timeout:(int)timeout;


/**
 断开设备连接
 */
+ (void)disconnectDevice;


/**
 中心蓝牙状态
 @return                        中心蓝牙状态
*/
+ (CBManagerState)centralManagerState;


/**
 BLE连接状态
 @return                        BLE连接状态
 */
+ (LWBleStatus)bleStatus;


/**
 设置设备系统类型（iOS）
 @note  ⚠️重要：每次连接成功都必须设置
 */
+ (void)setDeviceSystemTypeWithCallback:(LWResultCallback)callback;


/**
 设置设备系统时间
 @note  ⚠️跟随本地系统时间
 */
+ (void)setDeviceSystemTimeWithCallback:(LWResultCallback)callback;


/**
 设置设备系统语言
 @param language                语言类型
 */
+ (void)setDeviceSystemLanguage:(LWLanguageType)language withCallback:(LWResultCallback)callback;


/**
 设置设备系统音量
 @param volume                  音量值（0-16）
 */
+ (void)setDeviceSystemVolume:(int)volume withCallback:(LWResultCallback)callback;


/**
 获取设备系统音量
 @param callback                number数值：音量值
 */
+ (void)getDeviceSystemVolumeWithCallback:(LWResultNumberCallback)callback;


/**
 设置设备屏幕亮度
 @param brightness              亮度值：0-100
 */
+ (void)setDeviceScreenBrightness:(int)brightness withCallback:(LWResultCallback)callback;


/**
 获取设备屏幕亮度
 @param callback                number数值：亮度值
 */
+ (void)getDeviceScreenBrightnessWithCallback:(LWResultNumberCallback)callback;


/**
 绑定宠物
 @param identifier              绑定标识符
 @param callback                number数值：0表示绑定成功，其他则表示失败
 */
+ (void)bindAipetWithIdentifier:(NSString * _Nonnull)identifier withCallback:(LWResultNumberCallback)callback;


/**
 解绑宠物
 @param identifier              解绑标识符
 @param callback                number数值：0表示解绑成功，其他则表示失败
 */
+ (void)unbindAipetWithIdentifier:(NSString * _Nonnull)identifier withCallback:(LWResultNumberCallback)callback;


/**
 获取宠物状态
 @param callback                object宠物状态
 */
+ (void)getAipetStatusWithCallback:(LWResultAipetStatusCallback)callback;


/**
 设置宠物进化
 @param evolvedModel            进化信息
 @param callback                number数值：0表示进化成功，其他则表示失败
 */
+ (void)setEvolvedAipetWithModel:(LWAipetEvolvedModel * _Nonnull)evolvedModel withCallback:(LWResultNumberCallback)callback;


/**
 设置宠物奖励
 @param aipetReward             奖励信息
 @param callback                number数值：0表示奖励成功，其他则表示失败
 */
+ (void)setAipetRewardWithModel:(LWAipetRewardModel * _Nonnull)aipetReward withCallback:(LWResultCallback)callback;


/**
 设置今天天气
 @param weatherModel            天气信息
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setTodayWeatherWithModel:(LWTodayWeatherModel * _Nonnull)weatherModel withCallback:(LWResultNumberCallback)callback;


/**
 设置小时天气
 @param lists                   天气信息
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setHourWeatherWithLists:(NSArray <LWHourWeatherModel *> * _Nonnull)lists withCallback:(LWResultNumberCallback)callback;


/**
 添加新动画
 @param animationModel          动画信息
 @param callback                number数值：0表示添加成功，其他则表示失败
 */
+ (void)addNewAnimationWithModel:(LWAnimationModel * _Nonnull)animationModel withCallback:(LWResultNumberCallback)callback;


/**
 设置设备停止录音
 */
+ (void)setDeviceStopAudioRecordingWithCallback:(LWResultCallback)callback;


/**
 opus转pcm（音频流数据）
 @param opus                    opus音频流数据
 @return                        成功则返回pcm音频流数据，失败为nil
 */
+ (NSData * _Nullable)opusStream2pcm:(NSArray <NSData *> * _Nonnull)opus;


/**
 opus转ogg（音频流数据）
 @param opus                    opus音频流数据
 @return                        成功则返回ogg音频流数据，失败为nil
 */
+ (NSData * _Nullable)opusStream2ogg:(NSArray <NSData *> * _Nonnull)opus;


/**
 设置车载模式
 @param open                    车载模式：YES表示开启，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setCarMode:(BOOL)open withCallback:(LWResultNumberCallback)callback;


/**
 获取车载模式
 @param callback                number数值：0表示关闭，1表示开启
 */
+ (void)getCarModeWithCallback:(LWResultNumberCallback)callback;


/**
 从服务器请求离线语音授权码
 @param mac                     设备Mac地址
 @param lang                    离线语音语种简写：如英文en
 */
+ (void)requestOfflineVoiceAuthCodeWithMac:(NSString * _Nonnull)mac withLang:(NSString * _Nonnull)lang withCallback:(LWResultOfflineVoiceAuthCodeCallback)callback;


/**
 设置离线语音授权码
 @param authorizeCode           授权码
 @param callback                number数值：0表示授权成功，其他则表示失败
 */
+ (void)setOfflineVoiceAuthorizeCode:(NSString * _Nonnull)authorizeCode withCallback:(LWResultNumberCallback)callback;


/**
 设置节日动画
 @param holidayAnimationModel   节日动画
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setHolidayAnimationWithModel:(LWHolidayAnimationModel * _Nonnull)holidayAnimationModel withCallback:(LWResultNumberCallback)callback;


/**
 设置设备地区
 @param areaCode                地区编号
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDeviceAreaCode:(NSInteger)areaCode withCallback:(LWResultNumberCallback)callback;


/**
 设置AI对话语音情绪
 @param moodCode                情绪编号
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setAiDialogueVoiceMoodCode:(NSInteger)moodCode withCallback:(LWResultNumberCallback)callback;


/**
 从服务器请求星历文件
 */
+ (void)requestEphemerisFileWithCallback:(LWResultEphemerisCallback)callback;


/**
 文件上传协商
 @param negotModel              文件协商信息
 @note  ⚠️先调用此API协商，根据结果再开始上传文件 详@link startUploadingFilesWithModel:withProgressCallback:withResultCallback:
 */
+ (void)fileUploadNegotiationWithModel:(LWUploadFileNegotModel * _Nonnull)negotModel withCallback:(LWResultUploadNegotCallback)callback;


/**
 开始上传文件
 @param uploadFileModel         文件上传信息
 @param progressCallback        上传进度回调，progress进度0-100
 @param callback                文件上传结果，error为nil时表示成功
 @note  ⚠️调用此API之前，需要先协商 详@link fileUploadNegotiationWithModel:withCallback:
 */
+ (void)startUploadingFilesWithModel:(LWUploadFileModel * _Nonnull)uploadFileModel withProgressCallback:(LWResultProgressCallback)progressCallback withCallback:(LWResultCallback)callback;


/**
 设备AI语音播放控制
 @param play                    播放控制，YES表示开始播放，NO表示结束播放
 */
+ (void)deviceAiVoicePlaybackControl:(BOOL)play withCallback:(LWResultCallback)callback;


/**
 获取设备版本信息
 @param callback                object设备版本信息
 */
+ (void)getDeviceVersionInfoWithCallback:(LWResultDeviceVersionCallback)callback;


/**
 设置KWS命令词开关状态
 @param code                    KWS命令词编号
 @param status                  开关状态，YES表示打开，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setKWSCommandWord:(NSInteger)code status:(BOOL)status withCallback:(LWResultNumberCallback)callback;


/**
 设置POI打卡地列表
 @param list                    POI打卡地信息
 @note  ⚠️打卡地结果更新 详@link 【LDelegate】devicePoiCheckInSpotsUpdateWithModel:
 */
+ (void)setPoiCheckInSpotsWithList:(NSArray <LWCheckInSpotsModel *> * _Nonnull)list withCallback:(LWResultCallback)callback;


/**
 设置勿扰模式
 @param mode                    勿扰开关，YES表示打开，NO表示关闭
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDoNotDisturbMode:(BOOL)mode withCallback:(LWResultNumberCallback)callback;


/**
 获取勿扰模式
 @param callback                number数值：0表示关闭，1表示开启
 */
+ (void)getDoNotDisturbModeWithCallback:(LWResultNumberCallback)callback;


/**
 设置设备A2DP连接
 @param connect                 事件，YES表示连接A2DP，NO表示断开A2DP
 @param callback                number数值：0表示设置成功，其他则表示失败
 */
+ (void)setDeviceA2DPConnection:(BOOL)connect withCallback:(LWResultNumberCallback)callback;


/**
 响应设备交互
 @param error_code              错误码，0表示响应成功，其他则表示失败
 */
+ (void)respondDeviceInteraction:(NSInteger)error_code withCallback:(LWResultCallback)callback;


/**
 调试模式命令
 */
+ (void)debugModeWithCommand:(LWDebugModeCommand)command withCallback:(LWResultCallback)callback;


/**
 设置设备执行动画命令
 */
+ (void)setDeviceExecutionAnimationWithCommand:(LWAnimationCommand)command withCallback:(LWResultCallback)callback;


/**
 资源文件diff更新协商
 @param size                    所有资源文件大小，字节
 @param callback                number数值：0表示可以更新，其他则表示失败
 */
+ (void)resourceFileDiffUpdateNegotiationWithSize:(NSUInteger)size withCallback:(LWResultNumberCallback)callback;


/**
 删除设备文件或目录
 @param filePath                文件或目录绝对路径
 @param callback                number数值：0表示删除成功，其他则表示失败
 */
+ (void)deleteDeviceFilesOrDirectories:(NSString * _Nonnull)filePath withCallback:(LWResultNumberCallback)callback;


/**
 初始化音频格式（开始）
 @param audioFormat             音频格式
 @param callback                number数值：0表示初始化成功，其他则表示失败
 */
+ (void)initAudioFormat:(LWAudioFormatModel * _Nonnull)audioFormat withCallback:(LWResultNumberCallback)callback;


/**
 初始化音频元信息
 @param audioMeta               音频元信息
 @param callback                number数值：0表示初始化成功，其他则表示失败
 */
+ (void)initAudioMeta:(LWAudioMetaModel * _Nonnull)audioMeta withCallback:(LWResultNumberCallback)callback;


/**
 发送音频数据
 @param audioData               音频数据
 */
+ (void)sendAudioData:(NSData * _Nonnull)audioData withCallback:(LWResultCallback)callback;


/**
 音频数据发送完成，请求校验文件
 @param audioData               音频数据
 @param streamId                流ID
 @param fileId                  文件ID
 @param callback                number数值：0表示文件校验失败，其他则表示失败
 */
+ (void)requestVerifyAudioData:(NSData * _Nonnull)audioData streamId:(NSInteger)streamId fileId:(NSInteger)fileId withCallback:(LWResultNumberCallback)callback;


/**
 响应发送的音频总数量（结束）
 @param audioCount              音频总数量
 @param streamId                流ID
 */
+ (void)respondSentAudioCount:(NSInteger)audioCount streamId:(NSInteger)streamId withCallback:(LWResultCallback)callback;


/**
 响应当前APP状态
 @param states                  APP状态
 */
+ (void)respondCurrentAppStates:(LWAppStatus)states withCallback:(LWResultCallback)callback;

@end

NS_ASSUME_NONNULL_END
