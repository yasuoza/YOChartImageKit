@import UIKit;

@interface YOSimpleLineChartImage : NSObject

@property (assign) CGFloat strokeWidth;

@property UIColor *strokeColor;

@property UIColor *fillColor;

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
