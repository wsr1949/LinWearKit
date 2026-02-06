//
//  LWMacro.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-16.
//

#ifndef LWMacro_h
#define LWMacro_h


/// 部分定义的错误码
typedef NS_ENUM(NSInteger, LWErrorCode)
{
    /// 蓝牙未激活
    LWErrorCodeNotActivated         = 10001,
    /// 蓝牙未连接
    LWErrorCodeBleNotConnected      = 10002,
    /// 蓝牙连接超时
    LWErrorCodeConnectTimeout       = 10003,
    /// 命令响应超时
    LWErrorCodeCmdRespTimeout       = 10004,
    /// 数据检查未通过
    LWErrorCodeDataCheckFailed      = 10005,
    /// 上传文件失败
    LWErrorCodeFileUploadFailed     = 10006,
    
} NS_SWIFT_NAME(LWErrorCode);


/// BLE连接状态
typedef NS_ENUM(NSInteger, LWBleStatus)
{
    /// 连接断开
    LWBleStatusDisconnect           = 0,
    /// 连接中（初始化中）
    LWBleStatusConnecting           = 1,
    /// 已连接（初始化完成）
    LWBleStatusConnected            = 2,
    /// 连接失败
    LWBleStatusConnectionFailed     = 3,
    
} NS_SWIFT_NAME(LWBleStatus);


/// 显示屏形状
typedef NS_ENUM(NSInteger, LWScreenShape)
{
    /// 长方形
    LWScreenShape_Rect              = 0,
    /// 圆形
    LWScreenShape_Circ              = 1,
    /// 正方形
    LWScreenShape_Sq                = 2,
    
} NS_SWIFT_NAME(LWScreenShape);


/// 语言类型
typedef NS_ENUM(NSInteger, LWLanguageType)
{
    /// 英文
    LWLanguageType_EN               = 0,
    /// 中文
    LWLanguageType_ZH               = 1,
    
} NS_SWIFT_NAME(LWLanguageType);


/// 录音功能
typedef NS_ENUM(NSInteger, LWAudioFunction)
{
    /// 语音唤醒
    LWAudioFunction_Vad             = 0,
    /// 工具型问答
    LWAudioFunction_Agent           = 1,
    
} NS_SWIFT_NAME(LWAudioFunction);


/// 撸宠动作
typedef NS_ENUM(NSInteger, LWAipetAction)
{
    /// 戳脸
    LWAipetAction_PokingFace_1      = 0,
    /// 多次戳脸
    LWAipetAction_PokingFace_2      = 1,
    /// 摇晃
    LWAipetAction_Shake_1           = 2,
    /// 长时间摇晃
    LWAipetAction_Shake_2           = 3,
    
} NS_SWIFT_NAME(LWAipetAction);


/// 音频格式
typedef NS_ENUM(NSInteger, LWAudioFormat)
{
    /// pcm
    LWAudioFormat_PCM               = 0,
    /// opus
    LWAudioFormat_OPUS              = 1,
    
} NS_SWIFT_NAME(LWAudioFormat);


/// 文件类型
typedef NS_ENUM(NSInteger, LWFileType)
{
    /// 默认
    LWFileType_Default              = 0,
    /// 星历文件
    LWFileType_Ephemeris            = 1,
    /// 固件
    LWFileType_Firmware             = 2,
    
} NS_SWIFT_NAME(LWFileType);


/// 文件操作类型
typedef NS_ENUM(NSInteger, LWFileOperateType)
{
    /// 上传
    LWFileOperateType_Upload        = 0,
    /// 覆盖
    LWFileOperateType_Overwrite     = 1,
    
} NS_SWIFT_NAME(LWFileOperateType);


/// 文件上传协商类型
typedef NS_ENUM(NSInteger, LWFileUploadNegotType)
{
    /// 协商成功，允许上传
    LWFileUploadNegotType_Allow             = 0,
    /// 上传文件空间不足
    LWFileUploadNegotType_Space             = 1,
    /// 上传的文件已存在
    LWFileUploadNegotType_Repeat            = 2,
    /// 需要替换的文件不存在
    LWFileUploadNegotType_Replace           = 3,
    
} NS_SWIFT_NAME(LWFileUploadNegotType);


/// POI打卡类型
typedef NS_ENUM(NSInteger, LWPoiCheckInType)
{
    /// 单人打卡
    LWPoiCheckInType_Singles        = 0,
    /// 双人打卡
    LWPoiCheckInType_Doubles        = 1,
    
} NS_SWIFT_NAME(LWPoiCheckInType);


/// 交互类型
typedef NS_ENUM(NSInteger, LWInteractionType)
{
    /// 根据当前时间段，生成对应TTS
    LWInteractionType_Time          = 0,
    /// 查询当前天气，生成对应TTS
    LWInteractionType_Weather       = 1,
    /// 查询当天日期，生成对应节日TTS
    LWInteractionType_Festival      = 2,
    /// 需要上传Poi经纬度位置
    LWInteractionType_Poi           = 3,
    /// 心灵鸡汤（每天第一次亮屏）
    LWInteractionType_FirstSoul     = 4,
    /// 上车提醒（打开车载模式）
    LWInteractionType_BoardTime     = 5,
    /// 到达提醒（关闭车载模式）
    LWInteractionType_ArriveTime    = 6,
    
} NS_SWIFT_NAME(LWInteractionType);


/// 调试模式命令
typedef NS_ENUM(NSInteger, LWDebugModeCommand)
{
    /// 恢复宠物默认形象
    LWDebugModeCommand_RestorePet   = 0,
    /// 更多待拓展...
    
} NS_SWIFT_NAME(LWDebugModeCommand);


/// 动画命令
typedef NS_ENUM(NSInteger, LWAnimationCommand)
{
    /// aimon sit down
    LWAnimationCommand_0    = 0,
    /// aimon down / lie down
    LWAnimationCommand_1    = 1,
    /// aimon good / good boy / good girl
    LWAnimationCommand_2    = 2,
    /// aimon shake hand / aimon paw
    LWAnimationCommand_3    = 3,
    /// aimon jump
    LWAnimationCommand_4    = 4,
    /// aimon say hi
    LWAnimationCommand_5    = 5,
    /// aimon kiss
    LWAnimationCommand_6    = 6,
    /// aimon wag tail
    LWAnimationCommand_7    = 7,
    
} NS_SWIFT_NAME(LWAnimationCommand);


/// BR连接配对状态
typedef NS_ENUM(NSInteger, LWPairingStatus)
{
    /// 已连接
    LWPairingStatus_Connected       = 0,
    /// 未配对
    LWPairingStatus_Unpaired        = 1,
    /// 正在配对
    LWPairingStatus_Pairing         = 2,
    /// 已配对
    LWPairingStatus_Paired          = 3,
    /// 未连接
    LWPairingStatus_Disconnected    = 4,
    
} NS_SWIFT_NAME(LWPairingStatus);


#endif /* LWMacro_h */
