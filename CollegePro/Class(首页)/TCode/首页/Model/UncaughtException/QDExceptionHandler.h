//
//  QDExceptionHandler.h
//  UncaughtExceptionHandler
//
//  Created by 陈博文 on 16/8/23.
//  Copyright © 2016年 Cocoa with Love. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface QDExceptionHandler : NSObject
void UncaughtExceptionHandler(NSException *exception);
@end
