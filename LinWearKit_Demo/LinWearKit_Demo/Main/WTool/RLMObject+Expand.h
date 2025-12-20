//
//  RLMObject+Expand.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLMObject (Expand)

/// 保存or更新
- (void)saveOrUpdateObject;

/// 删除
- (void)deleteObject;

@end

NS_ASSUME_NONNULL_END
