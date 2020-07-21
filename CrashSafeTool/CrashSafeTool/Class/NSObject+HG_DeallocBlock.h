//
//  NSObject+HG_DeallocBlock.h
//  ExceptionProtector
//
//  Created by yuxiang on 2020/7/18.
//  Copyright © 2020年 hoge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (HG_DeallocBlock)

/**
  dealloc时执行的block

 @param block dealloc callback
 */
- (void)hg_deallocBlock:(dispatch_block_t)block;
@end
