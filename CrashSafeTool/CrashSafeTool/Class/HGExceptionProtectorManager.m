//
//  HGExceptionProtectorManager.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "HGExceptionProtectorManager.h"
#import "HG_CrashProtectorProtocol.h"
static HGExceptionProtectorManager *instance = nil;

@interface HGExceptionProtectorManager()
{
    dispatch_semaphore_t _swizzleLock;//保证在执行方法交换是线程安全的
}
@property (nonatomic, strong) NSMutableArray *saveProtectorClassArr;
@end

@implementation HGExceptionProtectorManager
- (instancetype)init {
    self = [super init];
    if (self) {
        _swizzleLock = dispatch_semaphore_create(1);
    }
    return self;
}
+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HGExceptionProtectorManager alloc] init];
    });
    return instance;
}

/**
 开启单个防护类型
 
 @param type 类型
 */
- (void)setSingleProtectorType:(HGExceptionProtectorType)type {
    
    switch (type) {
        case HGExcepitionProtectorString:
        {
            Class cls = NSClassFromString(@"NSString");
            [self addClassToArray:cls];
            
            Class clsM = NSClassFromString(@"NSMutableString");
            [self addClassToArray:clsM];
        }
            break;
        case HGExcepitionProtectorArray:
        {
            Class cls = NSClassFromString(@"NSArray");
            [self addClassToArray:cls];
            
            Class clsM = NSClassFromString(@"NSMutableArray");
            [self addClassToArray:clsM];
        }
            break;
        case HGExcepitionProtectorDictionary:
        {
            Class cls = NSClassFromString(@"NSDictionary");
            [self addClassToArray:cls];
            
            Class clsM = NSClassFromString(@"NSMutableDictionary");
            [self addClassToArray:clsM];
        }
            break;
        case HGExceptionProtectorSet:
        {
            Class cls = NSClassFromString(@"NSSet");
            [self addClassToArray:cls];
            
            Class clsM = NSClassFromString(@"NSMutableSet");
            [self addClassToArray:clsM];
            
        }
            break;
            
        case HGExceptionProtectorBasic:
        {
            {
                Class cls = NSClassFromString(@"NSString");
                [self addClassToArray:cls];
                
                Class clsM = NSClassFromString(@"NSMutableString");
                [self addClassToArray:clsM];
            }
            
            {
                Class cls = NSClassFromString(@"NSArray");
                [self addClassToArray:cls];

                Class clsM = NSClassFromString(@"NSMutableArray");
                [self addClassToArray:clsM];
            }
            
            {
                Class cls = NSClassFromString(@"NSDictionary");
                [self addClassToArray:cls];

                Class clsM = NSClassFromString(@"NSMutableDictionary");
                [self addClassToArray:clsM];
            }

            {
                Class cls = NSClassFromString(@"NSSet");
                [self addClassToArray:cls];

                Class clsM = NSClassFromString(@"NSMutableSet");
                [self addClassToArray:clsM];
            }
            
        }
            break;
        default:
            break;
    }
}

/// 设置开启基础的所有防护类型
- (void)setBasicProtection  {
    [self setSingleProtectorType:HGExceptionProtectorBasic];
}

/**
 开启所以得防护
 */
- (void)setAllProtector {
    
}

- (void)startProtection {
    dispatch_semaphore_wait(_swizzleLock, DISPATCH_TIME_FOREVER);
    [self.saveProtectorClassArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj performSelector:@selector(hg_swizzlingMethod)];
    }];
    dispatch_semaphore_signal(_swizzleLock);
}

- (void)addClassToArray:(Class)cls
{
    if ([cls conformsToProtocol:@protocol(HG_CrashProtectorProtocol)]) {
        
        [self.saveProtectorClassArr addObject:cls];
        
    };
}

#pragma mark - lazyload
- (NSMutableArray *)saveProtectorClassArr {
    if (!_saveProtectorClassArr) {
        _saveProtectorClassArr = [NSMutableArray array];
    }
    return _saveProtectorClassArr;
}
@end
