//
//  LWAipetActionModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAipetActionModel : NSObject

/// 撸宠时间戳
@property (nonatomic, assign) NSInteger timestamp;

/// 撸宠动作
@property (nonatomic, assign) LWAipetAction action;

@end

NS_ASSUME_NONNULL_END
