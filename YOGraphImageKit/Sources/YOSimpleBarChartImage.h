@import UIKit;

@interface YOSimpleBarChartImage : NSObject

@property (assign) CGFloat strokeWidth;

@property UIColor *barFillColor;

@property UIColor *barStrokeColor;

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
