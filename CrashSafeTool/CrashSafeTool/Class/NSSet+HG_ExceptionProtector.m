//
//  NSSet+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSSet+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSSet (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      hg_swizzleClassMethodImplementation(NSClassFromString(@"NSSet"),
                                          @selector(setWithObject:),
                                          @selector(safeSetWithObject:));
   });
}

+ (instancetype)safeSetWithObject:(id)anyObject {
   if (anyObject) {
      return [self safeSetWithObject:anyObject];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
      return nil;
   }
}
@end
