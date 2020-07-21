//
//  NSObject+HG_Swizzling.h
//  Demo
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020 hoge. All rights reserved.
//------------------------------------
//  此类提供方法交换
//------------------------------------

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 两个实例方法交换
/// @param class 当前交换方法的类
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
void hg_swizzleInstanceMethodImplementation(Class class, SEL originSel, SEL swizzledSel);
/// 两个实例方法交换
/// @param class 当前交换方法的类
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
void hg_swizzleClassMethodImplementation(Class class, SEL originSel, SEL swizzledSel);

@interface NSObject (HG_Swizzling)

/// 交换实例方法
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
+ (void)hg_swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel;

/// 交换类方法
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
+ (void)hg_swizzleClassMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel;
@end

NS_ASSUME_NONNULL_END
