//
//  LabelNilMethodBlockViewController.h
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MyReturnTextBlock)(NSString *showText);

@interface LabelNilMethodBlockViewController : BaseViewController
@property (nonatomic, copy) MyReturnTextBlock myReturnTextBlock;

@end
