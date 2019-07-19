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
        
        if (self.onlyPositiveBars) {
			normalizedValue = fabs(normalizedValue);
        }

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

        int cornerRadius = (self.roundedCaps) ? self.capsCornerRadius : 0.0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
        path.lineWidth = self.strokeWidth;
        
        NSArray *gradientColors;
        if ([self.values objectAtIndex:idx].doubleValue > 0) {
            gradientColors = [NSArray arrayWithObjects: (id)self.positiveColor.CGColor, (id)self.positiveGradientColor.CGColor, nil];
        } else {
            gradientColors = [NSArray arrayWithObjects: (id)self.negativeColor.CGColor, (id)self.negativeGradientColor.CGColor, nil];
        }
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSaveGState(context);
        [path addClip];
        [self drawGradientInRect:rect withGradientColors:(__bridge CFArrayRef)(gradientColors) inContext:context];
        CGContextRestoreGState(context);
    }];
    

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


-(void) drawGradientInRect:(CGRect) rect withGradientColors:(CFArrayRef)gradientColors inContext:(CGContextRef) context
{
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = {0.0, 0.1};
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, gradientColors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    
}

@end
