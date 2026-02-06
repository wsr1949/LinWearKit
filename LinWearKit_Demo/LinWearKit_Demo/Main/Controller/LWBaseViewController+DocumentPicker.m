//
//  LWBaseViewController+DocumentPicker.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2026-01-22.
//

#import "LWBaseViewController+DocumentPicker.h"
#import <UniformTypeIdentifiers/UniformTypeIdentifiers.h>

@interface LWBaseViewController () <UIDocumentPickerDelegate>

@property (nonatomic, copy) LWDocumentPickerCallback pickerCallback;

@property (nonatomic, assign) int maximumCount;

@end

@implementation LWBaseViewController (DocumentPicker)

- (LWDocumentPickerCallback)pickerCallback {
    return objc_getAssociatedObject(self, @selector(pickerCallback));
}
- (void)setPickerCallback:(LWDocumentPickerCallback)pickerCallback {
    objc_setAssociatedObject(self, @selector(pickerCallback), pickerCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (int)maximumCount {
    return [objc_getAssociatedObject(self, @selector(maximumCount)) intValue];
}
- (void)setMaximumCount:(int)maximumCount {
    objc_setAssociatedObject(self, @selector(maximumCount), @(maximumCount), OBJC_ASSOCIATION_ASSIGN);
}


- (void)presentDocumentPickerViewController:(NSArray <UTType *> *)contentTypes maximumCount:(int)maximumCount
{
    self.maximumCount = maximumCount;
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:contentTypes];
    documentPickerViewController.delegate = self;
    if (maximumCount > 1) {
        documentPickerViewController.allowsMultipleSelection = YES;
    }
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}


/// 选择固件
- (void)documentPickerWithFirmware:(LWDocumentPickerCallback)pickerCallback
{
    self.pickerCallback = pickerCallback;
    
    UTType *fwpkgType = [UTType typeWithFilenameExtension:@"fwpkg"];
    
    [self presentDocumentPickerViewController:@[fwpkgType] maximumCount:1];
}


/// 选择资源
- (void)documentPickerWithResource:(LWDocumentPickerCallback)pickerCallback
{
    self.pickerCallback = pickerCallback;
    
    UTType *binType = [UTType typeWithFilenameExtension:@"bin"];
    
    [self presentDocumentPickerViewController:@[binType] maximumCount:3];
}


#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls
{
    if (!urls.count) return;
    
    if (self.maximumCount > 1 && urls.count > self.maximumCount) {
        [LWHUD showText:@"当前demo演示最多个数为3个"];
        return;
    }
    
    NSMutableArray <NSURL *> *tempURLs = [NSMutableArray arrayWithCapacity:urls.count];
    dispatch_group_t group = dispatch_group_create();
    
    for (NSURL *url in urls)
    {
        dispatch_group_enter(group);
        
        //开启文件权限
        BOOL permission = [url startAccessingSecurityScopedResource];
        if (permission) {
            // 通过文件协调工具来得到新的文件地址，以此得到文件保护功能
            NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] init];
            __block NSError *error;
            LWEAKSELF
            [fileCoordinator coordinateReadingItemAtURL:url options:NSFileCoordinatorReadingWithoutChanges error:&error byAccessor:^(NSURL * _Nonnull newURL) {
                
                // 获取临时目录
                NSString *tempDir = NSTemporaryDirectory();
                NSString *fileName = [newURL lastPathComponent];
                NSURL *tempURL = [NSURL fileURLWithPath:[tempDir stringByAppendingPathComponent:fileName]];
                
                // 删除已存在的文件
                NSFileManager *fileManager = [NSFileManager defaultManager];
                if ([fileManager fileExistsAtPath:tempURL.path]) {
                    [fileManager removeItemAtURL:tempURL error:nil];
                }
                
                // 复制文件到临时目录
                BOOL success = [fileManager copyItemAtURL:newURL toURL:tempURL error:&error];
                if (success) {
                    [tempURLs addObject:tempURL];
                } else {
                    [LWHUD showText:[NSString stringWithFormat:@"文件复制失败 %@", error]];
                }
                dispatch_group_leave(group);
            }];
            
            //关闭文件权限
            [url stopAccessingSecurityScopedResource];
            
            if (error) {
                [LWHUD showText:error.localizedDescription];
                dispatch_group_leave(group);
            }
        }
        else {
            [LWHUD showText:@"没有文件权限"];
            dispatch_group_leave(group);
        }
    }
    // 所有文件处理完成后回调
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (tempURLs.count) {
            if (self.pickerCallback) {
                self.pickerCallback([tempURLs copy]);
            }
        }
    });
}

@end
