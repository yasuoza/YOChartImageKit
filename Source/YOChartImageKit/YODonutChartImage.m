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

#if TARGET_OS_IOS
    return [self drawImagePreferringImageRenderer:frame scale:scale];
#else
    return [self drawImageForGeneral:frame scale:scale];
#endif
}

#pragma mark - Draw Image(Private)

#if TARGET_OS_IOS
- (UIImage *)drawImagePreferringImageRenderer:(CGRect)frame scale:(CGFloat)scale {
    if ([UIGraphicsImageRenderer class]) {
        return [[[UIGraphicsImageRenderer alloc] initWithSize:frame.size] imageWithActions:^(UIGraphicsImageRendererContext *rendererContext) {
            [self drawPathIn:frame];
        }];
    } else {
        return [self drawImageForGeneral:frame scale:scale];
    }
}
#endif

- (UIImage *)drawImageForGeneral:(CGRect)frame scale:(CGFloat)scale {
    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);
    [self drawPathIn:frame];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Draw Paths(Private)

- (void)drawPathIn:(CGRect)frame {
    CGFloat totalValue = [[_values valueForKeyPath:@"@sum.self"] floatValue];
    CGPoint center = {
        frame.size.width / 2,
        frame.size.height / 2
    };

    CGFloat maxLength = MIN(frame.size.width, frame.size.height);
    CGFloat radius = maxLength / 2 - _donutWidth / 2;

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
        UIColor *strokeColor = self.colors[idx];

        CGFloat endAngle = self.startAngle + 2.0 * M_PI * normalizedValue;
        UIBezierPath *donutPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                 radius:radius
                                                             startAngle:self.startAngle
                                                               endAngle:endAngle
                                                              clockwise:YES];
        donutPath.lineWidth = self.donutWidth;
        [strokeColor setStroke];
        [donutPath stroke];
        self.startAngle = endAngle;
    }];
}

@end
