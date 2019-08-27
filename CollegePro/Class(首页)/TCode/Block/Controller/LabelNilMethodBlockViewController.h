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
@property (nonatomic, copy) MyReturnTextBlock myReturnTextBlock;
//RTC回调
@property (nonatomic, copy) receiveNoti reception;
+(void)numberInfor:(void(^)(NSString * infor))inforBlock;
+(BOOL)isWhiteSkinColor;

@end
