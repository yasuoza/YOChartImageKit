@import UIKit;

@interface YOGraphBarChartImage : NSObject

@property NSArray __nonnull *values;

@property CGFloat strokeWidth;

@property UIColor __nullable *barFillColor;

@property UIColor __nullable *barStrokeColor;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
