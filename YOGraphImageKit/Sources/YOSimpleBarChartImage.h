@import UIKit;

@interface YOSimpleBarChartImage : NSObject

@property (assign) CGFloat strokeWidth;

@property UIColor __nullable *barFillColor;

@property UIColor __nullable *barStrokeColor;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
