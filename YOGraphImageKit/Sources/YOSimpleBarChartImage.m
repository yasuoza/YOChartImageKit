#import "YOSimpleBarChartImage.h"

@implementation YOSimpleBarChartImage

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    // Data population
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        CGFloat value = arc4random_uniform(50) + 1;
        [data addObject:[NSNumber numberWithFloat:value]];
    }

    // Normalize values
    CGFloat maxValue = [[data valueForKeyPath:@"@max.floatValue"] floatValue];
    for (int i = 0; i < data.count; i++) {
        CGFloat value = [data[i] floatValue];
        data[i] = [NSNumber numberWithFloat:value/maxValue];
    }

    CGFloat dataCount = (CGFloat)data.count;
    CGFloat barPadding = ceil(1.0/dataCount * 50.0f);
    CGFloat totalPadding = (dataCount - 1.0f) * barPadding;
    CGFloat barWidth = (frame.size.width - totalPadding) / dataCount;

    self.barFillColor = _barFillColor ? _barFillColor : [UIColor whiteColor];
    self.barStrokeColor = _barStrokeColor ? _barStrokeColor : [UIColor clearColor];

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    for (int i = 0; i < data.count; i++) {
        CGFloat value = [data[i] floatValue];
        CGRect rect = {
            (CGFloat)i * (barWidth + barPadding),
            frame.size.height * (1.0 - value),
            barWidth,
            frame.size.height / value
        };
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        path.lineWidth = _strokeWidth;
        [_barFillColor setFill];
        [path fill];

        [_barStrokeColor setStroke];
        [path stroke];
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
