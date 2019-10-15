//
//  LabelNilMethodBlockViewController.h
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyReturnTextBlock)(NSString *showText);
typedef void (^receiveNoti)(NSString *showText);
@interface LabelNilMethodBlockViewController : BaseViewController
extern NSString *lhString;//这里由于带有extern所以会被认为是全局变量
@property (nonatomic, copy) MyReturnTextBlock myReturnTextBlock;
//RTC回调
@property (nonatomic, copy) receiveNoti reception;
+(void)numberInfor:(void(^)(NSString * infor))inforBlock;
+(BOOL)isWhiteSkinColor;
//Block作为参数时，blockname不需要写在^后面，直接写在括号后面
- (void)eatWith:(void(^)(NSDictionary *dic))block;
//Block作为返回值(block作为方法的返回值)
- (void(^)(int i))run;
//链式调用方法
- (LabelNilMethodBlockViewController *(^)(NSString *city))travel;
// 防止多次调用
- (void)getShouldPrevent:(int)seconds;
@end
