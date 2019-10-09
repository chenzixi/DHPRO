//
//  PictureSelectionController.m
//  CollegePro
//
//  Created by jabraknight on 2019/6/12.
//  Copyright © 2019 jabrknight. All rights reserved.
//

//#ifdef __cplusplus

//#endif

#import "PictureSelectionController.h"

//#import <opencv2/opencv.hpp>
//#import <opencv2/imgproc/types_c.h>
//#import <opencv2/imgcodecs/ios.h>
#import <opencv2/opencv.hpp>
#import <opencv2/highgui.hpp>
#import <opencv2/cvconfig.h>
#import <opencv2/videoio/cap_ios.h>
#import <opencv2/imgproc/imgproc_c.h>
#import <opencv2/imgcodecs/ios.h>
//#import <opencv2/videoio/cap_ios.h>
//#import <opencv2/imgproc/imgproc_c.h>
#import <string.h>
#import <iostream>
#import <fstream>
char Book[] = " $@B%8&WM#*oahkbdpqwmZO0QLCJUYXzcvunxrjft/\|()1{}[]?-_+~<>i!lI;:,\"^`'.";

@interface PictureSelectionController ()<CvVideoCameraDelegate>{
    cv::Mat keepMatImg;
    BOOL touch;
    cv::Mat cvImage;
}

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PictureSelectionController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}
//char Chang(int gray) {
//    if(gray>240) return ' ';
//    int unit = 255.0 / strlen(Book);
//    return Book[int(gray / unit)];
//    //return int(gray / unit)? '0':'1';
//    //return rand()%2? '$':'%';
//}
//- (void)shibieP{
//    char name[] = "timg.jpg";
//    char name2[] = "timg.txt";
//    IplImage *a = cvLoadImage(name,0);
//    std::ofstream Txtout(name2);
//    for (int i = 0; i < a->height; i++) {
//        for (int j = 0; j < a->width; j++) {
//            CvScalar s = cvGet2D(a, i, j);
//            Txtout << Chang(s.val[0]);
//            printf("%c", Chang(s.val[0]));
//        }
//        Txtout << std::endl;
//        std::cout << std::endl;
//    }
//    Txtout.close();
//}
- (void)setup{
    [self.view addSubview:self.imageView];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    touch = YES;
    UIImage *image = [UIImage imageNamed:@"0"];
    UIImageToMat(image, cvImage);
    
    if(!cvImage.empty()&&touch == YES){
        cv::Mat gray;
        // 将图像转换为灰度显示
        cv::cvtColor(cvImage,gray,CV_RGB2GRAY);
        // 应用高斯滤波器去除小的边缘
        cv::GaussianBlur(gray, gray, cv::Size(5,5), 1.2,1.2);
        // 计算与画布边缘
        cv::Mat edges;
        cv::Canny(gray, edges, 0, 50);
        // 使用白色填充
        cvImage.setTo(cv::Scalar::all(225));
        // 修改边缘颜色
        cvImage.setTo(cv::Scalar(0,128,255,255),edges);
        // 将Mat转换为Xcode的UIImageView显示
        self.imageView.image = MatToUIImage(cvImage);
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    touch = NO;
    self.imageView.image = [UIImage imageNamed:@"0"];

}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        CGRect rect = [UIScreen mainScreen].bounds;
        _imageView.frame = rect;
        UIImage *image = [UIImage imageNamed:@"0"];
        _imageView.image = image;
    }
    return _imageView;
}
@end
