//
//  LWAudioPlayer.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-02-26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LWAudioPlayerState) {
    /// 播放开始
    LWAudioPlayerState_Start,
    /// 播放暂停
    LWAudioPlayerState_Pause,
    /// 播放结束
    LWAudioPlayerState_End,
    /// 播放失败
    LWAudioPlayerState_Failed,
};

@protocol LWAudioPlayerDelegate <NSObject>

- (void)audioPlayerDidUpdateStatus:(LWAudioPlayerState)state playbackId:(NSString *)playbackId;

@end


@interface LWAudioPlayer : NSObject

/// 设置播放url，注册委托代理
+ (void)setPlaybackData:(NSData *)audioData delegate:(id <LWAudioPlayerDelegate>)delegate playbackId:(NSString *)playbackId;

/// 总时长
+ (NSTimeInterval)duration;

/// 当前播放时间点
+ (NSTimeInterval)currentTime;

/// 从指定时间点开始播放，设置完之后要播放请再调用一下play
+ (void)playAtTime:(NSTimeInterval)time;

/// 是否正在播放
+ (BOOL)isPlaying;

/// 开始/继续播放
+ (void)play;

/// 暂停播放（调用play为继续播放）
+ (void)pause;

/// 停止播放（调用play为从头播放）
+ (void)stop;

@end

NS_ASSUME_NONNULL_END
