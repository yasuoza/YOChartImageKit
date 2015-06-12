@import UIKit;
@import CoreGraphics;

@interface YOSimplePieChartImage : NSObject

@property NSString *labelText;

@property UIColor *labelColor;

@property UIFont *labelFont;

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
