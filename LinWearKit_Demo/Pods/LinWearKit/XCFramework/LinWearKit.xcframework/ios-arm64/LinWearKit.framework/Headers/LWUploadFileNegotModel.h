//
//  LWUploadFileNegotModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWUploadFileNegotModel : NSObject

/// 目标路径
@property (nonatomic, copy) NSString *targetPath;

/// 文件路径
@property (nonatomic, copy) NSString *filePath;

/// 文件名称，如果不设置，SDK内部将默认使用文件路径filePath.lastPathComponent
@property (nonatomic, copy, nullable) NSString *fileName;

/// 文件类型
@property (nonatomic, assign) LWFileType fileType;

/// 文件操作类型
@property (nonatomic, assign) LWFileOperateType fileOperateType;

/// 是否支持断点续传
@property (nonatomic, assign) BOOL resuming;

@end

NS_ASSUME_NONNULL_END
