//
//  LWUploadFileModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWUploadFileModel : NSObject

/// 当前上传文件数据的偏移值
@property (nonatomic, assign) NSInteger fileOffset;

/// 文件路径
@property (nonatomic, copy) NSString *filePath;

@end

NS_ASSUME_NONNULL_END
