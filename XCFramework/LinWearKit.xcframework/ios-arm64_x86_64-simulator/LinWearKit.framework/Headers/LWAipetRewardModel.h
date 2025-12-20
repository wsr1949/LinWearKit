//
//  LWAipetRewardModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAipetRewardModel : NSObject

/// 抽奖物品动画形态类型（派生动画编号，根据高位0和1来判断普通款还是隐藏款）
@property (nonatomic, assign) NSInteger rewardType;

/// 抽奖动画编号
@property (nonatomic, assign) NSInteger rewardAnimation;

/// 进化总进度
@property (nonatomic, assign) NSInteger totalProgress;

/// 当前进度
@property (nonatomic, assign) NSInteger currentProgress;

@end

NS_ASSUME_NONNULL_END
