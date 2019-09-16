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
@property (nonatomic,assign) float tmp;
- (void)test;

//计算
+ (CGFloat)makeCalculator:(void(^)(Persion *rj_tool))block;

typedef Persion *_Nullable(^RJCalculator)(CGFloat num);

@property (nonatomic, strong, readonly) RJCalculator plus;//
@property (nonatomic, strong, readonly) RJCalculator subtract;
@property (nonatomic, strong, readonly) RJCalculator multiply;
@property (nonatomic, strong, readonly) RJCalculator divide;

//拼接字符串
+ (NSString *)makeAppendingString:(void(^)(Persion *rj_tool))block;

@property (nonatomic, strong, readonly) Persion *(^date)(NSString *str);
@property (nonatomic, strong, readonly) Persion *(^who)(NSString *str);
@property (nonatomic, strong, readonly) Persion *(^note)(NSString *str);

@end
//__nullable表示对象可以是NULL或nil，而__nonnull表示对象不应该为空
//复杂的指针类型(如id *)必须显示去指定是non null还是nullable。例如，指定一个指向nullable对象的nonnulla指针，可以使用”__nullable id * __nonnull”。
NS_ASSUME_NONNULL_END
