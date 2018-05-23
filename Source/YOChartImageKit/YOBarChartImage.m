#import "YOBarChartImage.h"

@implementation YOBarChartImage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _barStyle = YOBarChartImageBarStyleVertical;

        _barPadding = 0.0;
        _strokeWidth = 0.0;

        _fillColor = [UIColor whiteColor];
        _strokeColor = nil;
    }
    return self;
}

- (NSNumber *) maxValue {
    return _maxValue ? _maxValue : [NSNumber numberWithFloat:[[_values valueForKeyPath:@"@max.floatValue"] floatValue]];
}

const CGFloat kBarPaddingMultipler = 20.0f;

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    NSAssert(_values.count > 0, @"YOBarChartImage // must assign values property which is an array of NSNumber");

    CGFloat maxValue = self.maxValue.floatValue;
    CGFloat dataCount = (CGFloat)_values.count;

    CGFloat padding;
    if (_barPadding > 0.0f) {
        padding = _barPadding;
    } else {
        padding = ceil(1.0f / dataCount * kBarPaddingMultipler);
    }
    CGFloat totalPadding = (dataCount - 1.0f) * padding;
    CGFloat totalWidth = _barStyle == YOBarChartImageBarStyleVertical ? (frame.size.width - totalPadding) : (frame.size.height - totalPadding);
    CGFloat barWidth = totalWidth / dataCount;

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    [_values enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *_) {
        CGFloat normalizedValue = number.floatValue / maxValue;

        CGRect rect;
        if (self.barStyle == YOBarChartImageBarStyleVertical) {
            rect = (CGRect) {
                (CGFloat)idx * (barWidth + padding) + self.strokeWidth / 2,
                frame.size.height * (1.0 - normalizedValue) + self.strokeWidth / 2,
                barWidth - self.strokeWidth,
                frame.size.height / normalizedValue
            };
        } else {
            rect = (CGRect) {
                -self.strokeWidth,
                (CGFloat)idx * (barWidth + padding) + self.strokeWidth / 2,
                frame.size.width * normalizedValue + self.strokeWidth / 2,
                barWidth - self.strokeWidth
            };
        }

        UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
        path.lineWidth = self.strokeWidth;
        [self.fillColor setFill];
        [path fill];

        [self.strokeColor setStroke];
        [path stroke];
    }];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
