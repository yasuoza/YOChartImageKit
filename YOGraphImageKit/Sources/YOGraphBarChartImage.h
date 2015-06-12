@import UIKit;

@interface YOGraphBarChartImage : NSObject

@property (nonnull) NSArray<NSNumber *> *values;

@property CGFloat strokeWidth;

@property (nullable) UIColor *barFillColor;

@property (nullable) UIColor *barStrokeColor;

- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
