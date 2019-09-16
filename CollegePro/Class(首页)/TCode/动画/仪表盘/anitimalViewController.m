//
//  anitimalViewController.m
//  CollegePro
//
//  Created by jabraknight on 2019/9/2.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "anitimalViewController.h"
#import "CircleViewView.h"
#import "ZPCAshapelGradientView.h"
#import "GradualColor_View.h"

#define GRADUALVIE_WIDTH 200

@interface anitimalViewController ()
@property (nonatomic, weak) GradualColor_View *gradualView;

@end

@implementation anitimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CircleViewView *circle = [[CircleViewView alloc] initWithFrame:CGRectMake(80, 70, 200, 200)];
    circle.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:circle];
    // Do any additional setup after loading the view.
    
    
    ZPCAshapelGradientView *view = [[ZPCAshapelGradientView alloc] initWithFrame:CGRectMake(40, 300, 200, 200)];
    //    view.progressLineWidth = 90;//最大是45
    //    view.startAngle = -210;
    //    view.endAngle = 30;
    //    view.biggerTitle = @"属性居中，字体大小和颜色可以改变，自身大小为半径减去线宽，最好是 字少一些";
    view.biggerLabel.font = [UIFont systemFontOfSize:40];
    [self.view addSubview:view];

    GradualColor_View *gradualView = ({
        GradualColor_View *view = [[GradualColor_View alloc] initWithFrame:(CGRectMake((DH_DeviceWidth - GRADUALVIE_WIDTH) / 2, 550, GRADUALVIE_WIDTH, GRADUALVIE_WIDTH))];
        view.backgroundColor = [UIColor clearColor];
        view.layer.borderColor = [UIColor greenColor].CGColor;
        view.layer.borderWidth = 1.0;
        [self.view addSubview:view];
        view;
    });
    [self.gradualView setPercet:100.0 withTimer:1.8f];
    self.gradualView = gradualView;

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
