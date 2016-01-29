#import "YODonutChartImage.h"

@implementation YODonutChartImage

- (instancetype)init {
    self = [super init];
    if (self) {
        _startAngle = -M_PI_2;
        _donutWidth = 1.0;
        _labelColor = [UIColor blackColor];
        _labelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return self;
}

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    NSAssert(_values.count > 0, @"YODonutChartImage // must assign values property which is an array of NSNumber");
    NSAssert(_colors.count >= _values.count, @"YOGraphPieChartImage // must assign colors property which is an array of UIColor");

    CGFloat totalValue = [[_values valueForKeyPath:@"@sum.self"] floatValue];
    CGPoint center = {
        frame.size.width / 2,
        frame.size.height / 2
    };

    CGFloat maxLength = MIN(frame.size.width, frame.size.height);
    CGFloat radius = maxLength / 2 - _donutWidth / 2;

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    if (_labelText) {
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName: _labelColor,
                                     NSFontAttributeName: _labelFont,
                                     };
        CGSize size = [self.labelText boundingRectWithSize:CGSizeMake(maxLength, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
        [_labelText drawAtPoint:(CGPoint){center.x - size.width/2, center.y - size.height/2} withAttributes:attributes];
    }
    [_values enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *_) {
        CGFloat normalizedValue = number.floatValue / totalValue;
        UIColor *strokeColor = _colors[idx];

        CGFloat endAngle = _startAngle + 2.0 * M_PI * normalizedValue;
        UIBezierPath *donutPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                      radius:radius
                                                                  startAngle:_startAngle
                                                                    endAngle:endAngle
                                                                   clockwise:YES];
        donutPath.lineWidth = _donutWidth;
        [strokeColor setStroke];
        [donutPath stroke];
        _startAngle = endAngle;
    }];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
