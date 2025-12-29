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
 
 project    2025-12-29  Version:1.0.1   Build:2025122901
            1.新增请求离线语音授权码 参@link requestOfflineVoiceAuthCodeWithMac:withLang:withCallback:
 
 project    2025-12-20  Version:1.0.0   Build:2025122001
            1.首版
 */

#import <CoreBluetooth/CoreBluetooth.h>
#import <LinWearKit/LWMacro.h>

#import <LinWearKit/LWPeripheralModel.h>
#import <LinWearKit/LWDeviceConfigModel.h>
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

#import <LinWearKit/LWDelegate.h>
#import <LinWearKit/LWCallback.h>

#endif /* LWHeader_h */
