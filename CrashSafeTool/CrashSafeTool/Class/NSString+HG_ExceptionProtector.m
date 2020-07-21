//
//  NSString+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSString+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation NSString (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // NSString
        hg_swizzleClassMethodImplementation(NSClassFromString(@"NSString"), @selector(stringWithUTF8String:), @selector(safeStringWithUTF8String:));
        hg_swizzleClassMethodImplementation(NSClassFromString(@"NSString"), @selector(stringWithCString:encoding:), @selector(safeStringWithCString:encoding:));
        // __NSCFString
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFString"), @selector(characterAtIndex:), @selector(safeCharacterAtIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFString"), @selector(substringWithRange:), @selector(safeSubstringWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFString"), @selector(substringToIndex:), @selector(safeSubstringToIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFString"), @selector(rangeOfString:), @selector(safeRangeOfString:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFString"), @selector(substringFromIndex:), @selector(safeSubstringFromIndex:));
        
        //NSPlaceholderString
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSPlaceholderString"), @selector(initWithCString:encoding:), @selector(safeInitWithCString:encoding:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSPlaceholderString"), @selector(initWithString:), @selector(safeInitWithString:));
        
        // __NSCFConstantString
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFConstantString"), @selector(substringFromIndex:), @selector(safeSubstringFromIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFConstantString"), @selector(substringToIndex:), @selector(safeSubstringToIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFConstantString"), @selector(substringWithRange:), @selector(safeSubstringWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"__NSCFConstantString"), @selector(rangeOfString:options:range:locale:), @selector(safeRangeOfString:options:range:locale:));
        
        // NSTaggedPointerString
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSTaggedPointerString"), @selector(substringFromIndex:), @selector(safeSubstringFromIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSTaggedPointerString"), @selector(substringToIndex:), @selector(safeSubstringToIndex:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSTaggedPointerString"), @selector(substringWithRange:), @selector(safeSubstringWithRange:));
        hg_swizzleInstanceMethodImplementation(NSClassFromString(@"NSTaggedPointerString"), @selector(rangeOfString:options:range:locale:), @selector(safeRangeOfString:options:range:locale:));
    });
}

+ (NSString *)safeStringWithUTF8String:(const char *)cString
{
    if (cString) {
        return [self safeStringWithUTF8String:cString];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return nil;
    }
}

+ (nullable instancetype)safeStringWithCString:(const char *)cString encoding:(NSStringEncoding)enc
{
    if (cString) {
        return [self safeStringWithCString:cString encoding:enc];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return nil;
    }
}

- (unichar)safeCharacterAtIndex:(NSUInteger)index{
    if(index < self.length) {
        return [self safeCharacterAtIndex:index];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return 0;
    }
}

- (nullable instancetype)safeInitWithString:(id)cString
{
    if (cString) {
        return [self safeInitWithString:cString];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return nil;
    }
    
}

- (nullable instancetype)safeInitWithCString:(const char *)CString encoding:(NSStringEncoding)enc
{
    if (CString) {
        return [self safeInitWithCString:CString encoding:enc];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return self;
    }
    
}

- (NSRange)safeRangeOfString:(NSString *)searchString {
    if (searchString) {
        return [self safeRangeOfString:searchString];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return NSMakeRange(0, 0);
    }
}

- (NSString *)safeSubstringFromIndex:(NSUInteger)fromIndex
{
    if (fromIndex < self.length) {
        return [self safeSubstringFromIndex:fromIndex];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return self;
    }
}

- (NSString *)safeSubstringToIndex:(NSUInteger)toIndex
{
    if (toIndex < self.length) {
        return [self safeSubstringToIndex:toIndex];
    }else {
#ifdef DEBUG
        //TODO: 异常弹框处理
#else
        // TODO: 上报异常
#endif
        return self;
    }
}

- (NSString *)safeSubstringWithRange:(NSRange)range
{
    
    if (range.location > self.length
     || range.length > self.length
     || (range.location + range.length) > self.length) {
     #ifdef DEBUG
           //TODO: 异常弹框处理
     #else
           // TODO: 上报异常
     #endif
        return self;
    }
    
    return [self safeSubstringWithRange:range];
}

- (NSRange)safeRangeOfString:(NSString *)searchString
                     options:(NSStringCompareOptions)mask
                       range:(NSRange)range
                      locale:(nullable NSLocale *)locale
{
    
    if (!searchString || range.location > self.length
     || range.length > self.length
     || (range.location + range.length) > self.length) {
     #ifdef DEBUG
           //TODO: 异常弹框处理
     #else
           // TODO: 上报异常
     #endif
        return NSMakeRange(0, 0);
    }
    
    return [self safeRangeOfString:searchString
    options:mask
      range:range
     locale:locale];
}
@end


