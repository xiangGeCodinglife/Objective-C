//
//  NSMutableString+HG_ExceptionProtector.m
//  ModCrashSafeBase
//
//  Created by yuxiang on 2020/7/21.
//  Copyright © 2020 yuxiang. All rights reserved.
//

#import "NSMutableString+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSMutableString (HG_ExceptionProtector)
+(void)hg_swizzlingMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hg_swizzleInstanceMethodWithOriginSel:@selector(appendString:) swizzledSel:@selector(safeAppendString:)];
        [self hg_swizzleInstanceMethodWithOriginSel:@selector(replaceCharactersInRange:withString:) swizzledSel:@selector(safeReplaceCharactersInRange:withString:)];
        [self hg_swizzleInstanceMethodWithOriginSel:@selector(insertString:atIndex:) swizzledSel:@selector(safeInsertString:atIndex:)];
        [self hg_swizzleInstanceMethodWithOriginSel:@selector(deleteCharactersInRange:) swizzledSel:@selector(safeDeleteCharactersInRange:)];
        [self hg_swizzleInstanceMethodWithOriginSel:@selector(setString:) swizzledSel:@selector(safeSetString:)];
    });
}

- (void)safeReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString{
    if(range.location + range.length > self.length || !aString) {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
    }else {
        [self safeReplaceCharactersInRange:range withString:aString];
    }
}

- (void)safeInsertString:(NSString *)aString atIndex:(NSUInteger)loc{
    if (!aString || loc > self.length) {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
    }else {
        [self safeInsertString:aString atIndex:loc];
    }
}

- (void)safeDeleteCharactersInRange:(NSRange)range{
    if(range.location + range.length > self.length) {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
    }else {
        [self safeDeleteCharactersInRange:range];
    }
}

- (void)safeAppendString:(NSString *)aString{
    if(!aString) {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
    }else {
        [self safeAppendString:aString];
    }
}

- (void)safeSetString:(NSString *)aString{
    if(!aString) {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
    }else {
        [self safeSetString:aString];
    }
}


@end
