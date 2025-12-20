//
//  LWAipetStatusModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAipetStatusModel : NSObject

/// 电量
@property (nonatomic, assign) NSInteger battery;

/// 充电状态，YES标识充电中
@property (nonatomic, assign) BOOL charging;

/// 心情值
@property (nonatomic, assign) NSInteger mood;

@end

NS_ASSUME_NONNULL_END
