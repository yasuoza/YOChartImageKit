@import UIKit;
@import CoreGraphics;

@interface YOGraphPieChartImage : NSObject

@property NSArray __nonnull *values;

@property NSArray __nonnull *colors;

@property CGFloat lineWidth;

@property NSString __nullable *labelText;

@property UIColor __nullable *labelColor;

@property UIFont __nonnull *labelFont;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
