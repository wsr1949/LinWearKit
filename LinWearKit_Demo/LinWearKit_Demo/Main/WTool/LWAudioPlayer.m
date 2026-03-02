//
//  LWAudioPlayer.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-02-26.
//

#import "LWAudioPlayer.h"
#import <AVFAudio/AVFAudio.h>

@interface LWAudioPlayer () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, weak) id <LWAudioPlayerDelegate> delegate;
@property (nonatomic, copy) NSString *playbackId;

@end

#define LWAudioSessionInterruption  @"LWAudioSessionInterruption"

@implementation LWAudioPlayer

/// 单例
+ (LWAudioPlayer *)sharedInstance {
    static LWAudioPlayer *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LWAudioPlayer alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        /// 音频会话中断通知
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(audioSessionInterruption) name:LWAudioSessionInterruption object:nil];
    }
    return self;
}

- (void)audioSessionInterruption
{
    if (LWAudioPlayer.isPlaying) [LWAudioPlayer pause];
}

/// 设置播放url 注册委托代理
+ (void)setPlaybackData:(NSData *)audioData delegate:(id<LWAudioPlayerDelegate>)delegate playbackId:(NSString *)playbackId
{
    if (LWAudioPlayer.sharedInstance.audioPlayer && LWAudioPlayer.sharedInstance.audioPlayer.isPlaying) {
        [LWAudioPlayer stop];
    }
    
    NSError *error;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithData:audioData error:&error];
    if (error) {
        NSLog(@"📻音频播放器【音频%@】初始化失败 %@", audioData, error);
        [LWHUD showText:error.localizedDescription];
        
        if (delegate && [delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
            [delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_Failed playbackId:playbackId]; // 失败
        }
    } else {
        audioPlayer.delegate = LWAudioPlayer.sharedInstance;
        audioPlayer.volume = 1; // 音量，0-1之间
        
        LWAudioPlayer.sharedInstance.delegate = delegate;
        LWAudioPlayer.sharedInstance.playbackId = playbackId;
    }
    LWAudioPlayer.sharedInstance.audioPlayer = audioPlayer;
}

/// 总时长
+ (NSTimeInterval)duration
{
    return LWAudioPlayer.sharedInstance.audioPlayer.duration;
}

/// 当前播放时间点
+ (NSTimeInterval)currentTime
{
    return LWAudioPlayer.sharedInstance.audioPlayer.currentTime;
}

/// 从指定时间点开始播放，设置完之后要播放请再调用一下play
+ (void)playAtTime:(NSTimeInterval)time
{
    LWAudioPlayer.sharedInstance.audioPlayer.currentTime = MIN(time, [LWAudioPlayer duration]);
}

/// 是否正在播放
+ (BOOL)isPlaying
{
    return LWAudioPlayer.sharedInstance.audioPlayer.isPlaying;
}

/// 开始/继续播放
+ (void)play
{
    if ([LWAudioPlayer.sharedInstance.audioPlayer prepareToPlay]) { // 分配播放所需的资源，并将其加入内部播放队列
        // 设置后台播放，激活音频会话
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        NSError *error = nil;
        
        // 设置播放模式
        AVAudioSessionCategoryOptions options = AVAudioSessionCategoryOptionDefaultToSpeaker |
                                                AVAudioSessionCategoryOptionMixWithOthers |
                                                AVAudioSessionCategoryOptionDuckOthers; // 降低其他音频音量;
        
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord
                             mode:AVAudioSessionModeDefault
                          options:options
                            error:&error];
        if (error) {
            NSLog(@"设置音频会话类别失败 %@", error);
        }
        // 激活
        [audioSession setActive:YES error:&error];
        if (error) {
            NSLog(@"激活音频会话失败 %@", error);
        }
        
        [LWAudioPlayer.sharedInstance.audioPlayer play];
        
        if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
            [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_Start playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 开始
        }
    } else {
        if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
            [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_Failed playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 失败
        }
    }
}

/// 暂停播放（可调用play继续播放）
+ (void)pause
{
    if (!LWAudioPlayer.isPlaying) return;
    
    [LWAudioPlayer.sharedInstance.audioPlayer pause];
    
    if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
        [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_Pause playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 暂停
    }
}

/// 停止播放（调用play为从头播放）
+ (void)stop
{
    if (!LWAudioPlayer.isPlaying) return;
    
    [LWAudioPlayer.sharedInstance.audioPlayer stop];
    
    if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
        [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_End playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 结束
    }
}


#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // 播放完成调用
    NSLog(@"📻音频播放完成");
    if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
        [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_End playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 结束
    }
}

- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error {
    // 解码失败
    NSLog(@"📻音频播放器解码失败 %@", error);
    [LWHUD showText:error.localizedDescription];
    
    if (LWAudioPlayer.sharedInstance.delegate && [LWAudioPlayer.sharedInstance.delegate respondsToSelector:@selector(audioPlayerDidUpdateStatus:playbackId:)]) {
        [LWAudioPlayer.sharedInstance.delegate audioPlayerDidUpdateStatus:LWAudioPlayerState_Failed playbackId:LWAudioPlayer.sharedInstance.playbackId]; // 失败
    }
}

@end
