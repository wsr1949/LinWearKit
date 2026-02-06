//
//  LWBaseViewController+DocumentPicker.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-01-22.
//

#import "LWBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^LWDocumentPickerCallback)(NSArray <NSURL *> * documents);

@interface LWBaseViewController (DocumentPicker)

/// 选择固件
- (void)documentPickerWithFirmware:(LWDocumentPickerCallback)pickerCallback;

/// 选择资源
- (void)documentPickerWithResource:(LWDocumentPickerCallback)pickerCallback;

@end

NS_ASSUME_NONNULL_END
