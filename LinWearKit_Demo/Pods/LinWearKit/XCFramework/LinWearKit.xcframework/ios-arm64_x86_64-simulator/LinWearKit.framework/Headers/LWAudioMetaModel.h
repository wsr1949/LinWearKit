//
//  LWAudioMetaModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-03-04.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAudioMetaModel : NSObject

/// 当前音频文件大小，字节
@property (nonatomic, assign) NSUInteger fileSize;

/// 当前音频文件时长，毫秒
@property (nonatomic, assign) NSInteger duration;

/// 是否是最后一个音频文件
@property (nonatomic, assign) BOOL isLastFile;

/// 流ID
@property (nonatomic, assign) NSInteger streamId;

/// 文件ID
@property (nonatomic, assign) NSInteger fileId;

@end

NS_ASSUME_NONNULL_END
