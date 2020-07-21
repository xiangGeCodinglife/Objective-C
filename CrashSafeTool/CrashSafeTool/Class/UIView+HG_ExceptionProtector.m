//
//  UIView+HG_ExceptionProtector.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "UIView+HG_ExceptionProtector.h"
#import "NSObject+HG_Swizzling.h"

@implementation UIView (HG_ExceptionProtector)
+ (void)hg_swizzlingMethod {
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"UIView"), @selector(setNeedsLayout), @selector(safeSetNeedsLayout));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"UIView"), @selector(setNeedsDisplay), @selector(safeSetNeedsDisplay));
      hg_swizzleInstanceMethodImplementation(NSClassFromString(@"UIView"), @selector(setNeedsDisplayInRect:), @selector(safeSetNeedsDisplayInRect:));
   });
}

- (void)safeSetNeedsLayout
{
   
   if (![NSThread isMainThread]) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
         
         [self safeSetNeedsLayout];
         
      });
      
#if DEBUG
      NSString *message = [NSString stringWithFormat:@"You can not display UI on a background thread,-[%@ safeSetNeedsLayout]", [self class]];
      NSAssert(false, message);
#endif
      
   }
   
   [self safeSetNeedsLayout];
   
}

- (void)safeSetNeedsDisplay
{
   
   if (![NSThread isMainThread]) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
         
         [self safeSetNeedsDisplay];
         
      });
      
#if DEBUG
      NSString *message = [NSString stringWithFormat:@"You can not display UI on a background thread,-[%@ safeSetNeedsDisplay]", [self class]];
      NSAssert(false, message);
#endif
      
   }
   
   [self safeSetNeedsDisplay];
   
}

- (void)safeSetNeedsDisplayInRect:(CGRect)rect
{
   if (![NSThread isMainThread]) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
         
         [self safeSetNeedsDisplayInRect:rect];
         
      });
      
#if DEBUG
      
      NSString *message = [NSString stringWithFormat:@"You can not display UI on a background thread,-[%@ safeSetNeedsDisplayInRect:]", [self class]];
      NSAssert(false, message);
#endif
      
   }
   
   [self safeSetNeedsDisplayInRect:rect];
   
}
@end
