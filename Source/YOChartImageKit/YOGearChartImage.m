#import "YOGearChartImage.h"

@implementation YOGearChartImage


- (instancetype)init {
    self = [super init];
    if (self) {
        _startAngle = -M_PI_2;
        _gearWidth = 1.0;
        _labelColor = [UIColor blackColor];
        _labelFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    }
    return self;
}

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
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
    CGFloat totalValue = 100;
    CGPoint center = {
        frame.size.width / 2,
        frame.size.height / 2
    };

    CGFloat maxLength = MIN(frame.size.width, frame.size.height);
    CGFloat radius = maxLength / 2 - _gearWidth / 2;

    if (_labelText) {
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName: _labelColor,
                                     NSFontAttributeName: _labelFont,
                                     };
        CGSize size = [_labelText boundingRectWithSize:CGSizeMake(maxLength, CGFLOAT_MAX)
                                                   options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                                attributes:attributes
                                                   context:nil].size;
        [_labelText drawAtPoint:(CGPoint){center.x - size.width/2, center.y - size.height/2} withAttributes:attributes];
    }
    
    //Draw gear background
    UIColor *bgColor = [_backgroundColor colorWithAlphaComponent:_backgroundColorAlpha];
    
    CGFloat endAngle = _startAngle + 2.0 * M_PI * totalValue;
    UIBezierPath *donutPath = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:radius
                                                         startAngle:_startAngle
                                                           endAngle:endAngle
                                                          clockwise:YES];
    donutPath.lineWidth = _gearWidth;
    [bgColor setStroke];
    [donutPath stroke];
   
    
    //Draw colored gear
    CGFloat normalizedValue = _value.floatValue / totalValue;
    UIColor *strokeColor = _color;
    
    endAngle = _startAngle + 2.0 * M_PI * normalizedValue;
    donutPath = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:radius
                                                         startAngle:_startAngle
                                                           endAngle:endAngle
                                                          clockwise:YES];
    donutPath.lineWidth = _gearWidth;
    
    donutPath.lineCapStyle = kCGLineCapRound;
    [strokeColor setStroke];
    [donutPath stroke];
}

@end
