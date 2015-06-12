@import UIKit;

@interface YOGraphLineChartImage : NSObject

@property CGFloat strokeWidth;

@property UIColor __nullable *strokeColor;

@property UIColor __nullable *fillColor;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
