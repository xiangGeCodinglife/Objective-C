//
//  NSArray+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSArray+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSArray (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //类方法
        [NSArray hg_swizzleClassMethodWithOriginSel:@selector(arrayWithObject:) swizzledSel:@selector(safeArrayWithObject:)];
        [NSArray hg_swizzleClassMethodWithOriginSel:@selector(arrayWithObjects:count:) swizzledSel:@selector(safeArrayWithObjects:count:)];
        
        //实例方法
        // 初始化字典类
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSPlaceholderArray"),
                                               @selector(initWithObjects:count:),
                                               @selector(safeInitWithObjects:count:));
        
        // __NSArray0
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArray0"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArray0"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArray0"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
        
        // __NSArrayI
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeSubarrayWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
        
        // __NSArrayI_Transfer
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI_Transfer"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI_Transfer"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeSubarrayWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayI_Transfer"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
        
        // iOS10以上 __NSSingleObjectArrayI
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSSingleObjectArrayI"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSSingleObjectArrayI"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeSubarrayWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSSingleObjectArrayI"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
        
        // __NSFrozenArrayM
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSFrozenArrayM"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSFrozenArrayM"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeSubarrayWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSFrozenArrayM"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
        
        // __NSArrayReversed
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayReversed"),
                                               @selector(objectAtIndex:),
                                               @selector(safeObjectAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayReversed"),
                                               @selector(subarrayWithRange:),
                                               @selector(safeSubarrayWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSArrayReversed"),
                                               @selector(objectAtIndexedSubscript:),
                                               @selector(safeObjectAtIndexedSubscript:));
    });
}

+ (instancetype)safeArrayWithObject:(id)anObject {
    if (anObject) {
        return [self safeArrayWithObject:anObject];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return nil;
    }
}

+ (instancetype)safeArrayWithObjects:(const id [])objects count:(NSUInteger)count {
    NSInteger index = 0;
    id objs[count];
    for (NSInteger i = 0; i < count;i++) {
        if (objects[i]) {
            objs[index] = objects[i];
            index++;
        }else {
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
    }
    return [self safeArrayWithObjects:objs count:index];
}

- (instancetype)safeInitWithObjects:(id *)objects count:(NSUInteger)cnt
{
    for (NSUInteger i = 0; i < cnt; i++)
    {
        if (!objects[i]) {
            objects[i] = @"";
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
    }
    return [self safeInitWithObjects:objects count:cnt];
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

- (NSArray *)safeSubarrayWithRange:(NSRange)range {
    if (range.location + range.length <= self.count) {
        return [self safeSubarrayWithRange:range];
    }else if (range.location < self.count) {
        return [self safeSubarrayWithRange:NSMakeRange(range.location, self.count - range.location)];
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
