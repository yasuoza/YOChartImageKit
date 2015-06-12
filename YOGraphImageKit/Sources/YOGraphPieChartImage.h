@import UIKit;
@import CoreGraphics;

@interface YOGraphPieChartImage : NSObject

@property (nonnull) NSArray<NSNumber *> *values;

@property (nonnull) NSArray<UIColor *> *colors;

@property CGFloat lineWidth;

@property (nonnull) NSString *labelText;

@property (nonnull) UIColor *labelColor;

@property (nonnull) UIFont *labelFont;

- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
