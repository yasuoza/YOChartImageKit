@import UIKit;

@interface YOLineChartImage : NSObject

@property (nonnull) NSArray<NSNumber *> *values;

@property CGFloat strokeWidth;

@property (nullable) UIColor *strokeColor;

@property (nullable) UIColor *fillColor;

@property BOOL smooth;

- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
