//
//  NSObject+Tool.m
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import "NSObject+Tool.h"

@implementation NSObject (Tool)

/// 字体颜色，跟随系统：Light黑 Dark白
- (UIColor *)textColor
{
    return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
        return traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ? UIColor.whiteColor : UIColor.blackColor;
    }];
}

/// 背景颜色，跟随系统：Light白 Dark黑
- (UIColor *)bgColor
{
    return UIColor.systemBackgroundColor;
}

/// 快速创建列表TableView
- (UITableView *)mainTableView:(id)target
                         style:(UITableViewStyle)style
                       cellIds:(NSArray<NSString *> *)cellIds
               headerFooterIds:(NSArray<NSString *> *)headerFooterIds
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.delegate = target;
    tableView.dataSource = target;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    for (NSString *ids in cellIds) {
        [tableView registerClass:NSClassFromString(ids) forCellReuseIdentifier:ids];
    }
    for (NSString *ids in headerFooterIds) {
        [tableView registerClass:NSClassFromString(ids) forHeaderFooterViewReuseIdentifier:ids];
    }
    return tableView;
}

/// 快速创建列表Label
- (UILabel *)mainLabel:(UIFont *)font textColor:(UIColor *)color
{
    UILabel *label = [UILabel new];
    label.font = font;
    label.textColor = color;
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    return label;
}

/// pcm转wav音频格式（其实就是加个wav文件头）
- (NSData *)convertPcmToWav:(NSData *)pcmData sampleRate:(float)sampleRate channels:(int)channels bitsPerSample:(int)bitsPerSample
{
    if (!pcmData.length) return nil;
    
    int byteRate = channels * sampleRate * bitsPerSample / 8;
    int blockAlign = channels * bitsPerSample / 8;
    int dataSize = (int)[pcmData length];
    int fileSize = 44 + dataSize;
    
    // 创建 WAV 文件头
    NSMutableData *wavData = [NSMutableData data];
    
    // RIFF chunk descriptor
    [wavData appendBytes:"RIFF" length:4];
    
    int32_t chunkSize = CFSwapInt32HostToLittle(fileSize - 8);
    [wavData appendBytes:&chunkSize length:4];
    
    [wavData appendBytes:"WAVE" length:4];
    
    // fmt sub-chunk
    [wavData appendBytes:"fmt " length:4];
    
    int32_t subchunk1Size = CFSwapInt32HostToLittle(16); // PCM 格式固定 16
    [wavData appendBytes:&subchunk1Size length:4];
    
    int16_t audioFormat = CFSwapInt16HostToLittle(1); // PCM = 1
    [wavData appendBytes:&audioFormat length:2];
    
    int16_t numChannels = CFSwapInt16HostToLittle(channels);
    [wavData appendBytes:&numChannels length:2];
    
    int32_t sampleRateInt = CFSwapInt32HostToLittle((int32_t)sampleRate);
    [wavData appendBytes:&sampleRateInt length:4];
    
    int32_t byteRateInt = CFSwapInt32HostToLittle(byteRate);
    [wavData appendBytes:&byteRateInt length:4];
    
    int16_t blockAlignInt = CFSwapInt16HostToLittle(blockAlign);
    [wavData appendBytes:&blockAlignInt length:2];
    
    int16_t bitsPerSampleInt = CFSwapInt16HostToLittle(bitsPerSample);
    [wavData appendBytes:&bitsPerSampleInt length:2];
    
    // data sub-chunk
    [wavData appendBytes:"data" length:4];
    
    int32_t subchunk2Size = CFSwapInt32HostToLittle(dataSize);
    [wavData appendBytes:&subchunk2Size length:4];
    
    // 添加 PCM 数据
    [wavData appendData:pcmData];
    
    return [wavData copy];
}

@end
