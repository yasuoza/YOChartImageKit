#import "YOGraphLineChartImage.h"

@implementation YOGraphLineChartImage

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    // Data population
    NSMutableArray *data = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        CGFloat value = arc4random_uniform(50);
        [data addObject:[NSNumber numberWithFloat:value]];
    }
    for (int i = 1; i < data.count; i++) {
        data[i] = [NSNumber numberWithFloat:[data[i - 1] floatValue] + [data[i] floatValue]];
    }

    CGFloat pointX = frame.size.width / (data.count - 1);
    NSMutableArray *points = [NSMutableArray array];
    CGFloat maxValue = [[data valueForKeyPath:@"@max.floatValue"] floatValue];
    for (int i = 0; i < data.count; i++) {
        CGFloat ratioY = [data[i] floatValue] / maxValue;

        NSValue *pointValue = [NSValue valueWithCGPoint:(CGPoint){
            (float)i * pointX,
            frame.size.height * (1 - ratioY)
        }];
        [points addObject:pointValue];
    }

    UIGraphicsBeginImageContextWithOptions(frame.size, false, scale);

    UIBezierPath *path = [self quadCurvedPathWithPoints:points frame:frame];
    path.lineWidth = _strokeWidth;

    [_strokeColor setStroke];
    [path stroke];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Path generator

- (UIBezierPath *)quadCurvedPathWithPoints:(NSArray *)points frame:(CGRect)frame {
    UIBezierPath *linePath = [[UIBezierPath alloc] init];
    UIBezierPath *fillBottom = [[UIBezierPath alloc] init];

    CGPoint startPoint = (CGPoint){0, frame.size.height};
    CGPoint endPoint = (CGPoint){frame.size.width, frame.size.height};
    [fillBottom moveToPoint:endPoint];
    [fillBottom addLineToPoint:startPoint];

    CGPoint p1 = [points[0] CGPointValue];
    [linePath moveToPoint:p1];

    [fillBottom addLineToPoint:p1];

    if (points.count == 2) {
        CGPoint p2 = [points[1] CGPointValue];
        [linePath addLineToPoint:p2];
        return linePath;
    }

    for (int i = 0; i < points.count; i++) {
        NSValue *value = points[i];
        CGPoint p2 = value.CGPointValue;

        CGFloat deltaX = p2.x - p1.x;
        CGFloat controlPointX = p1.x + (deltaX / 2);

        CGPoint controlPoint1 = (CGPoint){controlPointX, p1.y};
        CGPoint controlPoint2 = (CGPoint){controlPointX, p2.y};

        [linePath addCurveToPoint:p2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];
        [fillBottom addCurveToPoint:p2 controlPoint1:controlPoint1 controlPoint2:controlPoint2];

        p1 = p2;
    }

    [_fillColor setFill];
    [fillBottom fill];

    return linePath;
}

@end
