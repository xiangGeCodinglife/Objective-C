//
//  NSObject+HG_UnrecoginzedSelProtector.h
//  Demo
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020 hoge. All rights reserved.
//------------------------------------
//  unrecognized selector 异常保护器
//------------------------------------


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (HG_UnrecoginzedSelProtector)
+ (void)hg_UnrecoginzedSelProtectorSwizzleMethond;
@end

NS_ASSUME_NONNULL_END
