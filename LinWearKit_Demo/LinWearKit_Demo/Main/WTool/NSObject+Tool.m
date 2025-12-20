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

@end
