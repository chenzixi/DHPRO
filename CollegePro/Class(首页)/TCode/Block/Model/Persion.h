//
//  Persion.h
//  15
//
//  Created by jabraknight on 2018/11/28.
//  Copyright © 2018 大爷公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Persion : NSObject
- (void)test;
@end
//__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空
//复杂的指针类型(如id *)必须显示去指定是non null还是nullable。例如，指定一个指向nullable对象的nonnulla指针，可以使用”__nullable id * __nonnull”。
NS_ASSUME_NONNULL_END
