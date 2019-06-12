//
//  AliRTCViewController.m
//  CollegePro
//
//  Created by jabraknight on 2019/6/12.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "AliRTCViewController.h"
#import <AliRTCSdk/AliRTCSdk.h>

@interface AliRTCViewController ()<AliRtcEngineDelegate>
/**
 @brief SDK实例
 */
@property (nonatomic, strong) AliRtcEngine *engine;
@end

@implementation AliRTCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频通话";
    // 创建SDK实例，注册delegate，extras可以为空
    _engine = [AliRtcEngine sharedInstance:self extras:@""];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
