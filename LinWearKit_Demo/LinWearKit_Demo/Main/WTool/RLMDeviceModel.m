//
//  RLMDeviceModel.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "RLMDeviceModel.h"

@implementation RLMDeviceModel

+ (NSString *)primaryKey {
    return K_Predicate_Properky(RLMDeviceModel, deviceMac);
}

@end
