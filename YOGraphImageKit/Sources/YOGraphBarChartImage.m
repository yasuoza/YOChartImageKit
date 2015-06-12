#import "YOGraphBarChartImage.h"

@implementation YOGraphBarChartImage

const CGFloat kBarPadding = 50.0f;

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    NSAssert(_values.count > 1, @"YOGraphBarChartImage // must assign values property which is an array of NSNumber");

    NSUInteger valuesCount = _values.count;
    CGFloat maxValue = [[_values valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat dataCount = (CGFloat)valuesCount;
    CGFloat barPadding = ceil(1.0/dataCount * kBarPadding);
    CGFloat totalPadding = (dataCount - 1.0f) * barPadding;
    CGFloat barWidth = (frame.size.width - totalPadding) / dataCount;

    self.barFillColor = _barFillColor ? _barFillColor : [UIColor whiteColor];
    self.barStrokeColor = _barStrokeColor ? _barStrokeColor : [UIColor clearColor];

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    [_values enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *_) {
        CGFloat normalizedValue = number.floatValue / maxValue;
        CGRect rect = {
            (CGFloat)idx * (barWidth + barPadding),
            frame.size.height * (1.0 - normalizedValue),
            barWidth,
            frame.size.height / normalizedValue
        };
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        path.lineWidth = _strokeWidth;
        [_barFillColor setFill];
        [path fill];

        [_barStrokeColor setStroke];
        [path stroke];
    }];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
