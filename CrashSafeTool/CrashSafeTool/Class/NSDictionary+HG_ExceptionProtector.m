//
//  NSDictionary+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSDictionary+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSDictionary (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hg_swizzleClassMethodImplementation([self class], @selector(dictionaryWithObject:forKey:), @selector(safeDictionaryWithObject:forKey:));
        hg_swizzleClassMethodImplementation([self class], @selector(dictionaryWithObjects:forKeys:count:), @selector(safeDictionaryWithObjects:forKeys:count:));
        
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSDictionary"), @selector(initWithObjects:forKeys:), @selector(safeInitWithObjects:forKeys:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSDictionary"), @selector(initWithObjects:forKeys:count:), @selector(safeInitWithObjects:forKeys:count:));
    });
}

- (instancetype)safeInitWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys
{
    //   if (objects && keys) {
    
    NSInteger count            = objects.count > keys.count ? keys.count : objects.count;
    
    NSMutableArray *newObjects = [NSMutableArray arrayWithCapacity:count];
    NSMutableArray *newkeys    = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 0; i < count; i++) {
        if (objects[i]) {
            
            newObjects[i] = objects[i];
            
        }else {
            newObjects[i] = @"";
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
        
        if (keys[i]) {
            newkeys[i]    = keys[i];
        }else {
            newkeys[i]    = @"";
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
    }
    
    return [self safeInitWithObjects:newObjects forKeys:newkeys];
    
    //   }
    
    //#ifdef DEBUG
    //   //TODO: 异常弹框处理
    //#else
    //   // TODO: 上报异常
    //#endif
    //
    //   return nil;
}

- (instancetype)safeInitWithObjects:(id)objects forKeys:(id)keys count:(NSUInteger)cnt {
    //   if (objects && keys) {
    for (NSInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            objects[i] = @"";
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
        
        if (!keys[i]) {
            keys[i] = @"";
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
    }
    return [self safeInitWithObjects:objects forKeys:keys count:cnt];
    //   }
    //   else {
    //      return nil;
    //   }
}

+ (instancetype)safeDictionaryWithObject:(id)object forKey:(id)key
{
    if (object && key) {
        return [self safeDictionaryWithObject:object forKey:key];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return nil;
    }
    
}

+ (instancetype)safeDictionaryWithObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt
{
    // 处理错误的数据，然后重新初始化一个字典
    NSUInteger index = 0;
    id  _Nonnull __unsafe_unretained newObjects[cnt];
    id  _Nonnull __unsafe_unretained newkeys[cnt];
    
    for (int i = 0; i < cnt; i++) {
        
        if (keys[i] && objects[i]) {
            newObjects[index] = objects[i];
            newkeys[index] = keys[i];
            
        }else {
            
#ifdef DEBUG
            //TODO: 异常弹框处理
#else
            // TODO: 上报异常
#endif
        }
        
        index++;
    }
    
    return [self safeDictionaryWithObjects:newObjects forKeys:newkeys count:index];
}
@end
