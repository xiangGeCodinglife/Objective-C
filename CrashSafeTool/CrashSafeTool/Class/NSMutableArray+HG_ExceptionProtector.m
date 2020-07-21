//
//  NSMutableArray+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSMutableArray+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSMutableArray (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      // __NSArrayM
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(addObject:),
                                             @selector(safeAddObject:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(objectAtIndexedSubscript:),
                                             @selector(safeObjectAtIndexedSubscript:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(insertObject:atIndex:),
                                             @selector(safeInsertObject:atIndex:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(removeObjectAtIndex:),
                                             @selector(safeRemoveObjectAtIndex:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(replaceObjectAtIndex:withObject:),
                                             @selector(safeReplaceObjectAtIndex:withObject:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(removeObjectsInRange:),
                                             @selector(safeRemoveObjectsInRange:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayM"),
                                             @selector(subarrayWithRange:),
                                             @selector(safeSubarrayWithRange:));
      
      // __NSCFArray
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(addObject:),
                                             @selector(safeAddObject:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(objectAtIndexedSubscript:),
                                             @selector(safeObjectAtIndexedSubscript:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(insertObject:atIndex:),
                                             @selector(safeInsertObject:atIndex:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(removeObjectAtIndex:),
                                             @selector(safeRemoveObjectAtIndex:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(replaceObjectAtIndex:withObject:),
                                             @selector(safeReplaceObjectAtIndex:withObject:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(removeObjectsInRange:),
                                             @selector(safeRemoveObjectsInRange:));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFArray"),
                                             @selector(subarrayWithRange:),
                                             @selector(safeSubarrayWithRange:));
   });
}

- (void)safeAddObject:(id)object {
   if (object) {
      [self safeAddObject:object];
   } else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}

- (id)safeObjectAtIndex:(NSUInteger)index {
   if (index < self.count) {
      return [self safeObjectAtIndex:index];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
      return nil;
   }
}

- (id)safeObjectAtIndexedSubscript:(NSInteger)index {
   if (index < self.count) {
      return [self safeObjectAtIndexedSubscript:index];
   } else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
      return nil;
   }
}

- (void)safeInsertObject:(id)anObject atIndex:(NSUInteger)index {
   if (anObject && index <= self.count) {
      [self safeInsertObject:anObject atIndex:index];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index {
   if (index < self.count) {
      [self safeRemoveObjectAtIndex:index];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
   if (index < self.count && anObject) {
      [self safeReplaceObjectAtIndex:index withObject:anObject];
   }else {
#ifdef DEBUG
      //TODO: 异常弹框处理
#else
      // TODO: 上报异常
#endif
   }
}

- (void)safeRemoveObjectsInRange:(NSRange)range {
    
    if (range.location > self.count
        || range.length > self.count
        || (range.location + range.length) > self.count) {
        #ifdef DEBUG
              //TODO: 异常弹框处理
        #else
              // TODO: 上报异常
        #endif
           return;
       }
       
       [self safeRemoveObjectsInRange:range];
}

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    
    if (range.location > self.count
     || range.length > self.count
     || (range.location + range.length) > self.count) {
     #ifdef DEBUG
           //TODO: 异常弹框处理
     #else
           // TODO: 上报异常
     #endif
        return nil;
    }
    
    return [self safeSubarrayWithRange:range];
    
}
@end
