//
//  UIViewController+topmost.h
//  JHUniversalApp
//
//  Created by  William Sterling on 15/8/3.
//  Copyright (c) 2015年  William Sterling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (topmost)

+ (UIViewController*) topMostController;

+ (id)getRootController;

/**
 *  回到主界面
 *
 *  @param view 当前显示的试图
 *  @param view 当前显示的试图
 */
+ (void)backToHostController:(UIView *)view viewController:(UIViewController *)vc;

/**
 *  回到主界面
 *
 *  @param view 当前显示的试图
 */
+ (void)backToHostController:(UIView *)view;

+ (void)openUrlWithServerUrl:(NSString *)serverUrl localUrl:(NSString *)localUrl;
@end
