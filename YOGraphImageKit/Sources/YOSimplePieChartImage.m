#import "YOSimplePieChartImage.h"

@implementation YOSimplePieChartImage

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    CGFloat value = 0.4f;
    CGFloat lineWidth = 10.0f;
    UIColor *strokeColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];

    CGPoint center = {
        frame.size.width / 2,
        frame.size.height / 2
    };

    CGFloat maxLength = MIN(frame.size.width, frame.size.height);
    CGFloat radius = maxLength / 2 - lineWidth / 2;

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    if (_labelText) {
        _labelColor = _labelColor ? _labelColor : [UIColor blackColor];
        _labelFont = _labelFont ? _labelFont : [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName: _labelColor,
                                     NSFontAttributeName: _labelFont,
                                     };
        CGSize size = [self.labelText boundingRectWithSize:CGSizeMake(frame.size.width, CGFLOAT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                      attributes:attributes
                                         context:nil].size;
        [_labelText drawAtPoint:(CGPoint){center.x - size.width/2, center.y - size.height/2} withAttributes:attributes];
    }

    UIBezierPath *backGroundPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                  radius:radius
                                                              startAngle:-M_PI_2
                                                                endAngle:M_PI_2 * 3
                                                               clockwise:YES];
    backGroundPath.lineWidth = lineWidth;

    [[[UIColor whiteColor] colorWithAlphaComponent:0.4] setStroke];
    [backGroundPath stroke];

    CGFloat endAngle = -M_PI_2 + 2.0 * M_PI * value;
    UIBezierPath *valuePath = [UIBezierPath bezierPathWithArcCenter:center
                                                             radius:radius
                                                         startAngle:-M_PI_2
                                                           endAngle:endAngle
                                                          clockwise:YES];
    valuePath.lineWidth = lineWidth;

    [strokeColor setStroke];
    [valuePath stroke];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
