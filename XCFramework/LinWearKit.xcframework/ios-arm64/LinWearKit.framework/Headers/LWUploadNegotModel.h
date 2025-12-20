//
//  LWUploadNegotModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWUploadNegotModel : NSObject

/// 文件上传协商类型
@property (nonatomic, assign) LWFileUploadNegotType negotType;

/// 支持断点续传时，已接收文件的偏移值
@property (nonatomic, assign) NSInteger fileOffset;

@end

NS_ASSUME_NONNULL_END
