//
//  NSObject+HG_UnrecoginzedSelProtector.m
//  Demo
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020 hoge. All rights reserved.
//

#import "NSObject+HG_UnrecoginzedSelProtector.h"
#import "NSObject+HG_Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (HG_UnrecoginzedSelProtector)
+ (void)hg_UnrecoginzedSelProtectorSwizzleMethond {
   /**
    在给程序添加消息转发功能以前，必须覆盖两个方法，即methodSignatureForSelector:和forwardInvocation:。
    methodSignatureForSelector:的作用在于为另一个类实现的消息创建一个有效的方法签名，必须实现，并且返回不为空的methodSignature，否则会crash。
    
    forwardInvocation:将选择器转发给一个真正实现了该消息的对象
    */
   
   /**
    参考学习文章：https://blog.csdn.net/cooldragon/article/details/52497064
    -forwardInvocation:在一个对象无法识别消息之前调用，再需要重载-methodSignatureForSelector:,因为在调用-forwardInvocation：之前是要把消息打包成NSIvocation对象的，所以需要-methodSignatureForSelector:重载，如果不能在此方法中不能不为空的NSMethodSignature对象，程序依然会崩溃
    */
    hg_swizzleInstanceMethodImplementation([self class], @selector(methodSignatureForSelector:), @selector(safeMethodSignatureForSel:));
    hg_swizzleInstanceMethodImplementation([self class], @selector(forwardInvocation:), @selector(safeForwardInvocation:));
}

- (NSMethodSignature *)safeMethodSignatureForSel:(SEL)aSel {
    NSMethodSignature *methodSignature = [self safeMethodSignatureForSel:aSel];
    if (methodSignature) {
        return methodSignature;
    }
    
    IMP originIMP = class_getMethodImplementation([NSObject class], @selector(methodSignatureForSelector:));
    IMP currentClsIMP = class_getMethodImplementation([self class], @selector(methodSignatureForSelector:));
    // 子类重载该方法，则返回nil
    if (originIMP != currentClsIMP) {
        return nil;
    }
    
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}

- (void)safeForwardInvocation:(NSInvocation *)invocation {
    NSString *reason = [NSString stringWithFormat:@"class:[%@] not found selector:(%@)",NSStringFromClass(self.class),NSStringFromSelector(invocation.selector)];
    NSException *exception = [NSException exceptionWithName:@"Unrecognized Selector"
      reason:reason
    userInfo:nil];
   
#ifdef DEBUG
   //TODO: 异常弹框处理
#else
   // TODO: 上报异常
#endif
   
}
@end
