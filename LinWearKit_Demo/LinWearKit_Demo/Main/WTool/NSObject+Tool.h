//
//  NSObject+Tool.h
//  LinWearKit_Demo
//
//  Created by LINWEAR on 2025-12-17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Tool)

/// 字体颜色，跟随系统：Light黑 Dark白
- (UIColor *)textColor;

/// 背景颜色，跟随系统：Light白 Dark黑
- (UIColor *)bgColor;

/// 快速创建列表TableView
- (UITableView *)mainTableView:(id)target
                         style:(UITableViewStyle)style
                       cellIds:(NSArray<NSString *> * _Nullable)cellIds
               headerFooterIds:(NSArray<NSString *> * _Nullable)headerFooterIds;

/// 快速创建列表Label
- (UILabel *)mainLabel:(UIFont *)font textColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
