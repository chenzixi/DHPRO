//
//  TodayTableHeaderView.m
//  CollegeProExtension
//
//  Created by jabraknight on 2019/5/27.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "TodayTableHeaderView.h"
@interface TodayTableHeaderView ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *label;
@end


@implementation TodayTableHeaderView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
        // 布局子视图
        [self mas_layoutSubviews];
    }
    return self;
}
- (void)mas_layoutSubviews{
    self.imageView.frame = CGRectMake(15, 15, 70, 70);
    self.label.frame = CGRectMake(self.imageView.frame.origin.x+self.imageView.frame.size.width + 10 , self.imageView.center.y, 100, 20);
}
#pragma mark - lazy load
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.image = [UIImage imageNamed:@"ic_fast_order"];
        _imageView.layer.cornerRadius = 8.0;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.text = @"Hello World";
    }
    return _label;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
