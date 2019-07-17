
//
//  Persion.m
//  15
//
//  Created by jabraknight on 2018/11/28.
//  Copyright © 2018 大爷公司. All rights reserved.
//

#import "Persion.h"

@implementation Persion
- (void)test
{
    __block int age = 20;
    int *ptr = &age;
    void (^textBlock)(void) = ^{
        NSLog(@"(++age):%d", ++age);
    };
    textBlock();
    
    // 对block进行retain、release、copy，retainCount都不会变化，都为1
    //    [textBlock retain];
    //    [textBlock copy];
    //    [textBlock release];
    
    NSLog(@"Test: textBlock:%@, (*ptr):%d, %lu", textBlock, *ptr, (unsigned long)[textBlock retainCount]);
    /**
     MRC下：(++age):21   (*ptr):21
     */
    
#pragma mark - 对栈中的block进行copy
    // 不引用外部变量
    /* 这里打印的是__NSGlobalBlock__类型，但是通过clang改写的底层代码指向的是栈区：impl.isa = &_NSConcreteStackBlock
     这里引用巧神的一段话：由于 clang 改写的具体实现方式和 LLVM 不太一样，并且这里没有开启 ARC。所以这里我们看到 isa 指向的还是__NSStackBlock__。但在 LLVM 的实现中，开启 ARC 时，block 应该是 __NSGlobalBlock__ 类型
     */
    void (^testBlock1)(void) = ^(){
        
    };
    void (^testBlock2)(void) = [testBlock1 copy];
    NSLog(@"Test: testBlock1: %@, testBlock2: %@", testBlock1, testBlock2);
    [testBlock2 release];
    
    // 引用外部变量，block为__NSStackBlock__类型
    void (^testBlock3)(void) = ^(){
        age = age+1-1;
    };
    void (^testBlock4)(void) = [testBlock3 copy];
    NSLog(@"Test: testBlock3: %@, testBlock4: %@", testBlock3, testBlock4);
    [testBlock4 release];
}
@end
