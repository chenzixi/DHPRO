//
//  CameraResultLayerView.m
//  CollegePro
//
//  Created by jabraknight on 2019/6/11.
//  Copyright © 2019 jabrknight. All rights reserved.
//

#import "CameraResultLayerView.h"

@implementation CameraResultLayerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor* color2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 0.4];
    UIImage* image = [UIImage imageNamed: @"cameraView.tiff"];
    //// Rectangle Drawing
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect: self.bounds];
    CGContextSaveGState(context);
    [rectanglePath addClip];
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawTiledImage(context, self.bounds, image.CGImage);
    CGContextRestoreGState(context);
    
    
    //// Text Drawing
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, rect.size.width - 14, (rect.size.height - 262)/2);
    CGContextRotateCTM(context, 90 * M_PI/180);
    
    CGRect textRect = CGRectMake(0, 0, 262, 28);
    UIBezierPath* textPath = [UIBezierPath bezierPathWithRoundedRect: textRect cornerRadius: 14];
    [color2 setFill];
    [textPath fill];
    [UIColor.clearColor setStroke];
    textPath.lineWidth = 1;
    [textPath stroke];
    {
        NSString* textContent = @"请将证件四角尽量对齐取景框的四角";
        NSMutableParagraphStyle* textStyle = [[NSMutableParagraphStyle alloc] init];
        textStyle.alignment = NSTextAlignmentCenter;
        NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize: UIFont.systemFontSize], NSForegroundColorAttributeName: UIColor.whiteColor, NSParagraphStyleAttributeName: textStyle};
        
        CGFloat textTextHeight = [textContent boundingRectWithSize: CGSizeMake(textRect.size.width, INFINITY) options: NSStringDrawingUsesLineFragmentOrigin attributes: textFontAttributes context: nil].size.height;
        CGContextSaveGState(context);
        CGContextClipToRect(context, textRect);
        [textContent drawInRect: CGRectMake(CGRectGetMinX(textRect), CGRectGetMinY(textRect) + (textRect.size.height - textTextHeight) / 2, textRect.size.width, textTextHeight) withAttributes: textFontAttributes];
        CGContextRestoreGState(context);
    }
    
    CGContextRestoreGState(context);

}


@end
