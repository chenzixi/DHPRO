//
//  QDExceptionHandler.m
//  UncaughtExceptionHandler
//
//  Created by 陈博文 on 16/8/23.
//  Copyright © 2016年 Cocoa with Love. All rights reserved.
//

#import "QDExceptionHandler.h"
#import "QDExceptionTool.h"

@implementation QDExceptionHandler


// 设置一个C函数，用来接收崩溃信息
void UncaughtExceptionHandler(NSException *exception){
    // 可以通过exception对象获取一些崩溃信息，我们就是通过这些崩溃信息来进行解析的，例如下面的symbols数组就是我们的崩溃堆栈。

    
    //获取当前时间
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    //设置时间输出格式：
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init ];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * crashTime = [formatter stringFromDate:currentDate];
    
    //获取设备信息
    NSMutableDictionary *deviceDictionary = [NSMutableDictionary dictionary];
    
    UIDevice *device=[UIDevice currentDevice];
    [deviceDictionary setValue:device.name forKey:@"name"];
    [deviceDictionary setValue:device.model forKey:@"model"];
    [deviceDictionary setValue:device.localizedModel forKey:@"localizedModel"];
    [deviceDictionary setValue:device.systemName forKey:@"systemName"];
    [deviceDictionary setValue:device.systemVersion forKey:@"systemVersion"];
    [deviceDictionary setValue:device.identifierForVendor.UUIDString forKey:@"UUIDString"];
    
    
    NSMutableDictionary *exceptionDictionary = [NSMutableDictionary dictionary];
    
    NSArray *symbols = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    NSDictionary *userInfo = [exception userInfo];
    [exceptionDictionary setValue:crashTime forKey:@"crashTime"];
    [exceptionDictionary setValue:deviceDictionary forKey:@"deviceDictionary"];
    [exceptionDictionary setValue:symbols forKey:@"symbols"];
    [exceptionDictionary setValue:reason forKey:@"reason"];
    [exceptionDictionary setValue:name forKey:@"name"];
    [exceptionDictionary setValue:userInfo forKey:@"userInfo"];
    
    
    NSLog(@"%@",exceptionDictionary);
    
    [[QDExceptionTool shareExceptionTool]storeExceptionWithExceptionDictionary:exceptionDictionary];

    
}


@end
