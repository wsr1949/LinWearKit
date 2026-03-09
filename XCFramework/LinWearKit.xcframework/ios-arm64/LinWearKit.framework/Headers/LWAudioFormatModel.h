//
//  LWAudioFormatModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-03-04.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAudioFormatModel : NSObject

/// 音频格式，如"ogg"、"mp3"
@property (nonatomic, copy, nullable) NSString *format;

/// 采样率，默认16000
@property (nonatomic, assign) NSInteger sampleRate;

/// 声道数，默认1（单声道）
@property (nonatomic, assign) int channels;

/// 比特率，默认12800
@property (nonatomic, assign) NSInteger bitRate;

/// 帧时长，默认10ms
@property (nonatomic, assign) int frameDuration;

/// 流ID
@property (nonatomic, assign) NSInteger streamId;

@end

NS_ASSUME_NONNULL_END
