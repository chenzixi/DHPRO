//
//  KYDog.m
//  15
//
//  Created by jabraknight on 2019/4/9.
//  Copyright © 2019 大爷公司. All rights reserved.
//

#import "KYDog.h"

@implementation KYDog
/**
 什么是构造方法:初始化对象的方法。一般情况下,在 OC 当中创建1个对象分为两部分(new 做的事):alloc:分配内存空间，init :初始化对象。
 构造方法分为系统自带和自定义构造方法。
 （1）如果是系统自带的构造方法，需要重写父类中自带的构造方法 比如init
 （2）如果是自定义构造方法：属于对象方法那么以-号开头，返回值一般为id或者instancetype类型，方法名一般以init开头
 */
- (instancetype)initWithName:(NSString *)name andAge:(int)age{
    if (self = [super init]) {
        _name = name;
        _age = age;
    }
    return self;
}
@end

@implementation KYUser

@end
