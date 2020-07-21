//
//  NSMutableDictionary+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSMutableDictionary+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSMutableDictionary (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(safeSetObject:forKey:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(safeSetObject:forKeyedSubscript:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSDictionaryM"), @selector(removeObjectForKey:), @selector(safeRemoveObjectForKey:));
   });
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
   if (anObject && aKey) {
      [self safeSetObject:anObject forKey:aKey];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}


- (void)safeSetObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
   if (obj && key) {
      [self safeSetObject:obj forKeyedSubscript:key];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}


- (void)safeRemoveObjectForKey:(id)aKey
{
   if (aKey) {
      [self safeRemoveObjectForKey:aKey];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}
@end
