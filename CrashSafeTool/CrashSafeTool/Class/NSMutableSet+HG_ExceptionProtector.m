//
//  NSMutableSet+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSMutableSet+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSMutableSet (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSMutableSet"),
                                             @selector(addObject:),
                                             @selector(safeddObject:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSMutableSet"),
                                             @selector(removeObject:),
                                             @selector(safeRemoveObject:));
   });
}

- (void)safeddObject:(id)object {
   if (object) {
      [self safeddObject:object];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}

- (void)safeRemoveObject:(id)object {
   if (object) {
      [self safeRemoveObject:object];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}
@end
