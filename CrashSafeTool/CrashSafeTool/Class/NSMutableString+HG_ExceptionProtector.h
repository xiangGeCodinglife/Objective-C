//
//  NSMutableString+HG_ExceptionProtector.h
//  ModCrashSafeBase
//
//  Created by yuxiang on 2020/7/21.
//  Copyright © 2020 yuxiang. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "HG_CrashProtectorProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableString (HG_ExceptionProtector)<HG_CrashProtectorProtocol>

@end

NS_ASSUME_NONNULL_END
