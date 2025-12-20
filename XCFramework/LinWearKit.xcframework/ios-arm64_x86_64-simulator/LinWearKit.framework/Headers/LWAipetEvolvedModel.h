//
//  LWAipetEvolvedModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAipetEvolvedModel : NSObject

/// 宠物进化形象类型
@property (nonatomic, assign) NSInteger evolvedType;

/// 宠物进化时，背景音效
@property (nonatomic, assign) NSInteger evolvedAudio;

@end

NS_ASSUME_NONNULL_END
