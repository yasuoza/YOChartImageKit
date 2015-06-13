@import UIKit;

@interface YOGraphLineChartImage : NSObject

@property (nonnull) NSArray<NSNumber *> *values;

@property CGFloat strokeWidth;

@property (nullable) UIColor *strokeColor;

@property (nullable) UIColor *fillColor;

- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
