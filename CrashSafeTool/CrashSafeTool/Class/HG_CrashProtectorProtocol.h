//
//  HG_CrashProtectorProtocol.h
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HG_CrashProtectorProtocol <NSObject>
+ (void)hg_swizzlingMethod;
@end
