//
//  LWCheckInSpotsModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-01-08.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWCheckInSpotsModel : NSObject

/// 地点类型
@property (nonatomic, assign) NSInteger type;

/// 地点名称
@property (nonatomic, copy) NSString *name;

/// 动画编号
@property (nonatomic, assign) NSInteger animation;

/// 列表下标
@property (nonatomic, assign) NSInteger index;

@end

NS_ASSUME_NONNULL_END
