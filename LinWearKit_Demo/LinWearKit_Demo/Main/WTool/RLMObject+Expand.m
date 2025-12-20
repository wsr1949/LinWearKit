//
//  RLMObject+Expand.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "RLMObject+Expand.h"

@implementation RLMObject (Expand)

/// 保存or更新
- (void)saveOrUpdateObject
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:self];
    }];
}

/// 删除
- (void)deleteObject
{
    RLMRealm *realm = RLMRealm.defaultRealm;
    [realm transactionWithBlock:^{
        [realm deleteObject:self];
    }];
}

@end
