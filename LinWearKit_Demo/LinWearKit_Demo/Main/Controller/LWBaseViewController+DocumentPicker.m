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

@end

@implementation LWBaseViewController (DocumentPicker)

- (LWDocumentPickerCallback)pickerCallback {
    return objc_getAssociatedObject(self, @selector(pickerCallback));
}
- (void)setPickerCallback:(LWDocumentPickerCallback)pickerCallback {
    objc_setAssociatedObject(self, @selector(pickerCallback), pickerCallback, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


/// 选择固件
- (void)documentPickerWithFirmware:(LWDocumentPickerCallback)pickerCallback
{
    self.pickerCallback = pickerCallback;
    
    UTType *fwpkgType = [UTType typeWithFilenameExtension:@"fwpkg"];
    
    UIDocumentPickerViewController *documentPickerViewController = [[UIDocumentPickerViewController alloc] initForOpeningContentTypes:@[fwpkgType]];
    documentPickerViewController.delegate = self;
    [self presentViewController:documentPickerViewController animated:YES completion:nil];
}


#pragma mark - UIDocumentPickerDelegate

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *>*)urls
{
    NSURL *url = urls.firstObject;
    
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
                if (weakSelf.pickerCallback) weakSelf.pickerCallback(tempURL);
            } else {
                [LWHUD showText:[NSString stringWithFormat:@"文件复制失败 %@", error]];
                if (weakSelf.pickerCallback) weakSelf.pickerCallback(nil);
            }
        }];
        
        //关闭文件权限
        [url stopAccessingSecurityScopedResource];
        
        if (error) [LWHUD showText:error.localizedDescription];
    }
    else {
        [LWHUD showText:@"没有文件权限"];
        if (self.pickerCallback) self.pickerCallback(nil);
    }
}

@end
