#import "YODonutChartImage.h"

@implementation YODonutChartImage

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    NSAssert(_values.count > 0, @"YODonutChartImage // must assign values property which is an array of NSNumber");
    NSAssert(_colors.count >= _values.count, @"YOGraphPieChartImage // must assign colors property which is an array of UIColor");

    CGFloat totalValue = [[_values valueForKeyPath:@"@sum.self"] floatValue];
    CGPoint center = {
        frame.size.width / 2,
        frame.size.height / 2
    };

    CGFloat maxLength = MIN(frame.size.width, frame.size.height);
    CGFloat radius = maxLength / 2 - _lineWidth / 2;

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    if (_labelText) {
        _labelColor = _labelColor ? _labelColor : [UIColor blackColor];
        _labelFont = _labelFont ? _labelFont : [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
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

    __block CGFloat startAngle = -M_PI_2;
    [_values enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *_) {
        CGFloat normalizedValue = number.floatValue / totalValue;
        UIColor *strokeColor = _colors[idx];

        CGFloat endAngle = startAngle + 2.0 * M_PI * normalizedValue;
        UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                      radius:radius
                                                                  startAngle:startAngle
                                                                    endAngle:endAngle
                                                                   clockwise:YES];
        backGroundPath.lineWidth = _lineWidth;
        [strokeColor setStroke];
        [backGroundPath stroke];

        startAngle = endAngle;
    }];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
