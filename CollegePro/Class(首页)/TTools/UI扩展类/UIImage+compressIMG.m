//
//  UIImage+compressIMG.h
//  AFNetWorking再封装
//
//  Created by 邵峰 on 17/4/11.
//  Copyright © 2017年 邵峰. All rights reserved.
//

#import "UIImage+compressIMG.h"

@implementation UIImage (compressIMG)

/**
 渐变色

 @param colors 渐变颜色组
 @param gradientType 渐变方向 0从上到下 1从左到右
 @param imgSize 渐变区域
 @return 返回图片
 事例：
 UIImage *im = [UIImage getGradientImageFromColors:@[[UIColor redColor],[UIColor blueColor]] gradientType:1 imgSize:CGSizeMake(100, 100)];

 */
+ (UIImage *)getGradientImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case GradientTypeTopToBottom:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, imgSize.height);
            break;
        case GradientTypeLeftToRight:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(imgSize.width, 0.0);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}
+(UIImage *)IMGCompressed:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        
        NSAssert(!newImage,@"图片压缩失败");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

+ (instancetype)circleOldImage:(UIImage *)originalImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
	// 1.加载原图
	UIImage *oldImage = originalImage;
	
	// 2.开启上下文
	CGFloat imageW = oldImage.size.width + 2 * borderWidth;
	CGFloat imageH = oldImage.size.height + 2 * borderWidth;
	CGSize imageSize = CGSizeMake(imageW, imageH);
	UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
	
	// 3.取得当前的上下文
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	// 4.画边框(大圆)
	[borderColor set];
	CGFloat bigRadius = imageW * 0.5; // 大圆半径
	CGFloat centerX = bigRadius; // 圆心
	CGFloat centerY = bigRadius;
	CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
	CGContextFillPath(ctx); // 画圆
	
	// 5.小圆
	CGFloat smallRadius = bigRadius - borderWidth;
	CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
	// 裁剪(后面画的东西才会受裁剪的影响)
	CGContextClip(ctx);
	
	// 6.画图
	[oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
	
	// 7.取图
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	
	// 8.结束上下文
	UIGraphicsEndImageContext();
	
	return newImage;
}
//更改 UIImage 大小
-(UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize
{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return reSizeImage;
}
@end
