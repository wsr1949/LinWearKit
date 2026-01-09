//
//  LWCheckInSpotsResultModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2026-01-09.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWCheckInSpotsResultModel : NSObject

/// 错误码，0表示设置成功，其他则表示失败
@property (nonatomic, assign) NSInteger error_code;

/// 打卡点信息，成功时返回
@property (nonatomic, strong, nullable) LWCheckInSpotsModel *spotsModel;

@end

NS_ASSUME_NONNULL_END
