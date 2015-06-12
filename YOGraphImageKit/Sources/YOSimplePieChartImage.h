@import UIKit;
@import CoreGraphics;

@interface YOSimplePieChartImage : NSObject

@property (assign) CGFloat lineWidth;

@property NSString __nullable *labelText;

@property UIColor __nullable *labelColor;

@property UIFont __nonnull *labelFont;

- (UIImage __nonnull *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
