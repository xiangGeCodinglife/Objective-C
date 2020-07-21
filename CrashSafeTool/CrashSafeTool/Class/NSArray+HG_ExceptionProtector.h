//
//  NSArray+HG_ExceptionProtector.h
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//------------------------------------
//  不可变数组 异常保护器
//------------------------------------

#import <Foundation/Foundation.h>
#import "HG_CrashProtectorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (HG_ExceptionProtector)<HG_CrashProtectorProtocol>

@end

NS_ASSUME_NONNULL_END
