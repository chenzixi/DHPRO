//
//  LabelMethodBlockVC.h
//  Test
//
//  Created by Rillakkuma on 2016/11/29.
//  Copyright © 2016年 Rillakkuma. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ReturnTextBlock)(NSString *showText);

@interface LabelMethodBlockVC : BaseViewController
@property (nonatomic, copy) ReturnTextBlock returnTextBlock;

@end
