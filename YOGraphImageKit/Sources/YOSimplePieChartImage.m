#import "YOSimplePieChartImage.h"

@implementation YOSimplePieChartImage

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    // Sample data
    NSMutableArray *data = [@[@40.0f, @50.0f, @10.0f] mutableCopy];
    NSMutableArray *colors = [NSMutableArray array];
    for (int i = 0; i < data.count; i++) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        [colors addObject:[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1]];
    }

    // Normalize values
    CGFloat totalValue = [[data valueForKeyPath:@"@sum.self"] floatValue];
    for (int i = 0; i < data.count; i++) {
        CGFloat value = [data[i] floatValue];
        data[i] = [NSNumber numberWithFloat:value/totalValue];
    }

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

    CGFloat startAngle = -M_PI_2;
    CGFloat endAngle = startAngle;

    CGFloat value;
    UIColor *strokeColor;

    for (int i = 0; i < data.count; i++) {
        value = [data[i] floatValue];
        strokeColor = colors[i];

        endAngle = startAngle + 2.0 * M_PI * value;
        UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                      radius:radius
                                                                  startAngle:startAngle
                                                                    endAngle:endAngle
                                                                   clockwise:YES];
        backGroundPath.lineWidth = _lineWidth;
        [strokeColor setStroke];
        [backGroundPath stroke];

        startAngle = endAngle;
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
