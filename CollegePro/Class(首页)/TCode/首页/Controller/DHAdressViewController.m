//
//  DHAdressViewController.m
//  Test
//
//  Created by Rillakkuma on 2017/7/27.
//  Copyright © 2017年 Rillakkuma. All rights reserved.
//

#import "DHAdressViewController.h"

@interface DHAdressViewController ()

@end

@implementation DHAdressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isShowleftBtn = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jieshou) name:UIApplicationUserDidTakeScreenshotNotification object:nil];


    // Do any additional setup after loading the view.
}
- (void)jieshou{
    NSLog(@"接收");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
