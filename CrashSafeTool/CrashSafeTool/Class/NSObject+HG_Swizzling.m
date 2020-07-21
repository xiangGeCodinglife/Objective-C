//
//  NSObject+HG_Swizzling.m
//  Demo
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020 hoge. All rights reserved.
//

#import "NSObject+HG_Swizzling.h"
#import <objc/runtime.h>

/// 两个实例方法交换
/// @param class 当前交换方法的类
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
void hg_swizzleInstanceMethodImplementation(Class class, SEL originSel, SEL swizzledSel) {
    if (!class) {
        return;
    }
    
    NSLog(@"%@",class);
    
    Method originMethod = class_getInstanceMethod(class, originSel);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSel);
    
    if (!originMethod || !swizzledMethod) {
        return;
    }
    
    // 是否存在
    BOOL didAddMethod = class_addMethod(class, originSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    // 替换
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }else {
        class_replaceMethod(class,
                            swizzledSel,
                            class_replaceMethod(class,
                                                originSel,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originMethod));
    }
}

/// 两个实例方法交换
/// @param class 当前交换方法的类
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
void hg_swizzleClassMethodImplementation(Class class, SEL originSel, SEL swizzledSel) {
    if (!class) {
        return;
    }
    
    NSLog(@"%@",class);
    
    Class metaClass = objc_getMetaClass(NSStringFromClass(class).UTF8String);
    
    Method originMethod = class_getClassMethod(class, originSel);
    Method swizzledMethod = class_getClassMethod(class, swizzledSel);
    
    if (!originMethod || !swizzledMethod) {
        return;
    }
    
    // 是否存在
    BOOL didAddMethod = class_addMethod(metaClass, originSel,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    // 替换
    if (didAddMethod) {
        class_replaceMethod(metaClass, swizzledSel,
                            method_getImplementation(originMethod),
                            method_getTypeEncoding(originMethod));
    }else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

@implementation NSObject (HG_Swizzling)
/// 交换实例方法
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
+ (void)hg_swizzleInstanceMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel {
    Class class = [self class];
    hg_swizzleInstanceMethodImplementation(class, originSel, swizzledSel);
}

/// 交换类方法
/// @param originSel 原始方法
/// @param swizzledSel 交换方法
+ (void)hg_swizzleClassMethodWithOriginSel:(SEL)originSel swizzledSel:(SEL)swizzledSel {
    Class class = [self class];
    hg_swizzleClassMethodImplementation(class, originSel, swizzledSel);
}

@end
