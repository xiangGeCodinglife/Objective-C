//
//  NSObject+HG_DeallocBlock.m
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import "NSObject+HG_DeallocBlock.h"
#import <objc/runtime.h>

static const char DeallocNSObjectKey;

// 给要被释放的对象添加的中间对象，利用dealloc时会释放关联对象的那一步，这样无需hook dealloc方法节省性能开销
@interface DeallocMidObj : NSObject

@property (nonatomic,readwrite,copy) void(^deallocBlock)(void);

@end

@implementation DeallocMidObj

- (void)dealloc {
   if (_deallocBlock) {
      _deallocBlock();
   }
   _deallocBlock = nil;
}

@end

@implementation NSObject (HG_DeallocBlock)
- (void)hg_deallocBlock:(dispatch_block_t)block {
   @synchronized(self) {
      NSMutableArray *blockArray = objc_getAssociatedObject(self, &DeallocNSObjectKey);
      if (!blockArray) {
         blockArray = [NSMutableArray array];
         objc_setAssociatedObject(self, &DeallocNSObjectKey, blockArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
      }
      
      DeallocMidObj *midObj = [DeallocMidObj new];
      midObj.deallocBlock = block;
      [blockArray addObject:midObj];
   }
}
@end
