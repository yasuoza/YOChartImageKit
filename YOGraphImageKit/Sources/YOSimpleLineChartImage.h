@import UIKit;

@interface YOSimpleLineChartImage : NSObject

@property (assign) CGFloat strokeWidth;

@property UIColor __nullable *strokeColor;

@property UIColor __nullable *fillColor;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
