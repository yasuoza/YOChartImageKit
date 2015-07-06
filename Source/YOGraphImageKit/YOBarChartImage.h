@import UIKit;

@interface YOBarChartImage : NSObject

@property (nonnull) NSArray<NSNumber *> *values;

@property CGFloat barPadding;

@property CGFloat strokeWidth;

@property (nullable) UIColor *fillColor;

@property (nullable) UIColor *strokeColor;

- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
