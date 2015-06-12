@import UIKit;
@import CoreGraphics;

@interface YOGraphPieChartImage : NSObject

@property (assign) CGFloat lineWidth;

@property NSString __nullable *labelText;

@property UIColor __nullable *labelColor;

@property UIFont __nonnull *labelFont;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
