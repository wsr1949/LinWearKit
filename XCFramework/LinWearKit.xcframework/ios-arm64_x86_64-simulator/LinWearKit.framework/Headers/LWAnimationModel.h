//
//  LWAnimationModel.h
//  LinWearKit
//
//  Created by LINWEAR on 2025-12-18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LWAnimationModel : NSObject

/// 动画编号
@property (nonatomic, assign) NSInteger type;

/// 文件名称
@property (nonatomic, copy) NSString *name;

/// 动画帧图片数量
@property (nonatomic, assign) NSInteger count;

/// 序列帧坐标，用于裁剪后的序列帧动画，不配置默认 0
@property (nonatomic, assign) NSInteger point_x;

/// 序列帧坐标，用于裁剪后的序列帧动画，不配置默认 0
@property (nonatomic, assign) NSInteger point_y;

/// 图片最终显示尺寸 ， 如果is_scale==false,则是图片原尺寸；如果 is_scale==true,则是要放大的尺寸
@property (nonatomic, assign) NSInteger size_w;

/// 图片最终显示尺寸 ， 如果is_scale==false,则是图片原尺寸；如果 is_scale==true,则是要放大的尺寸
@property (nonatomic, assign) NSInteger size_h;

/// 是否放大
@property (nonatomic, assign) BOOL is_scale;

/// 是否多形态
@property (nonatomic, assign) BOOL is_multi_form;

/// 是否播放音效
@property (nonatomic, assign) BOOL is_play_sound;

@end

NS_ASSUME_NONNULL_END
