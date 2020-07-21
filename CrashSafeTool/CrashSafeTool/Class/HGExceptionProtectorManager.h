//
//  HGExceptionProtectorManager.h
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 配置防护崩溃类型
 */
typedef NS_OPTIONS(NSInteger,HGExceptionProtectorType)
{
    HGExceptionNone = 0,//不防护
    HGExceptionUnrecognizedSelector = 1 << 1,//方法不存在异常
    HGExcepitionProtectorString = 1 << 2,//防止字符串crash
    HGExcepitionProtectorArray = 1 <<3,//防止数组crash
    HGExcepitionProtectorDictionary = 1 <<4,//防止字典crash
    HGExceptionProtectorSet = 1 << 5,//防护nsset异常
    HGExceptionProtectorBasic = HGExcepitionProtectorString | HGExcepitionProtectorArray | HGExcepitionProtectorDictionary | HGExceptionProtectorSet,
    HGExceptionProtectorAll = HGExceptionUnrecognizedSelector | HGExcepitionProtectorString | HGExcepitionProtectorArray | HGExcepitionProtectorDictionary | HGExceptionProtectorSet
};

@interface HGExceptionProtectorManager : NSObject
+ (instancetype)shareInstance;

/// 设置开启单个防护类型
/// @param type 类型
- (void)setSingleProtectorType:(HGExceptionProtectorType)type;

/// 设置开启基础的所有防护类型
- (void)setBasicProtection;

/// 设置开启所有防护类型
- (void)setAllProtector;

/// 开启保护措施
- (void)startProtection;

@end
