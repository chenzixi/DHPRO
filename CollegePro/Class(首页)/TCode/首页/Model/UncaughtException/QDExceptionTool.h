//
//  QDExceptionTool.h
//  UncaughtExceptionHandler
//
//  Created by 陈博文 on 16/8/23.
//  Copyright © 2016年 Cocoa with Love. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDExceptionTool : NSObject


+ (instancetype)shareExceptionTool;

- (void)storeExceptionWithExceptionDictionary:(NSDictionary *)dictionary;

- (void)deleteException;

- (NSMutableArray *)getExceptionArray;

@end
