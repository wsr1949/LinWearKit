//
//  LWAnimationCmdModel.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-02-03.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAnimationCmdModel : NSObject

- (instancetype)initWithKws:(NSString *)kws command:(LWAnimationCommand)command;

@property (nonatomic, copy) NSString *kws;

@property (nonatomic, assign) LWAnimationCommand command;

@end

NS_ASSUME_NONNULL_END
