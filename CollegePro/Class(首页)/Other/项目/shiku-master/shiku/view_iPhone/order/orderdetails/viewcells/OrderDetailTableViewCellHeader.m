//
//  CartTableViewCellHeader.m
//  shiku
//
//  Created by txj on 15/5/11.
//  Copyright (c) 2015年 txj. All rights reserved.
//

#import "OrderDetailTableViewCellHeader.h"

@implementation OrderDetailTableViewCellHeader


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.*/
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGRect cellRect = self.frame;
    CGContextSetFillColorWithColor(context, BG_COLOR.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, cellRect.size.width, cellRect.size.height));
    self.statusLabel.textColor = MAIN_COLOR;
}


- (void)bind {
    @weakify(self)
    [RACObserve(self, shop_item)
            subscribeNext:^(id x) {
                @strongify(self);
                [self render];
            }];
}

- (void)unbind {
}

- (void)render {
    self.nameLabel.text = self.shop_item.name;
}

@end
