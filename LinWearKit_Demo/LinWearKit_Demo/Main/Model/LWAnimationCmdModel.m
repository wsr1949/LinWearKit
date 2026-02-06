//
//  LWAnimationCmdModel.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-02-03.
//

#import "LWAnimationCmdModel.h"

@implementation LWAnimationCmdModel

- (instancetype)initWithKws:(NSString *)kws command:(LWAnimationCommand)command {
    if (self = [super init]) {
        self.kws = kws;
        self.command = command;
    }
    return self;
}

@end
