#import "YODonutChartImage.h"

@implementation YODonutChartImage

NSMutableArray<UIImage *> *animationImages;
NSMutableArray<UIColor *> *animationColors;
NSMutableArray<NSNumber *> *animationValues;

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
}

- (NSArray<UIImage *> *)drawAnimationImages:(CGRect)frame scale:(CGFloat)scale {
    NSAssert(_values.count > 0, @"YODonutChartImage // must assign values property which is an array of NSNumber");
    NSAssert(_colors.count >= _values.count, @"YOGraphPieChartImage // must assign colors property which is an array of UIColor");
    NSAssert(_animationSteps != 0, @"YODonutChartImage // must assign animationSteps property wich is an int");
    
    //Normalization of values smaller then the minimum slice size
    int animationSlice = 100.0/_animationSteps;
    NSMutableArray<NSNumber*> *normalizedValues = [NSMutableArray arrayWithArray:_values];
    
    for(int i=0; i<normalizedValues.count; i++) {
        double val = normalizedValues[i].doubleValue;
        if (val < animationSlice) {
            normalizedValues[i] = [NSNumber numberWithInteger:animationSlice];
            NSNumber *max = [normalizedValues valueForKeyPath:@"@max.doubleValue"];
            normalizedValues[[normalizedValues indexOfObject:max]] = [NSNumber numberWithDouble:(max.doubleValue - (animationSlice-val))];
        }
    }
    
    //Images creation
    animationImages = [NSMutableArray array];
    animationColors = [NSMutableArray array];
    animationValues = [NSMutableArray array];
    
    double threshold = 0.0;
    int sliceIndex = 0;
    [animationColors addObject:[_colors objectAtIndex:sliceIndex]];
    double nextColorChange = [normalizedValues objectAtIndex:sliceIndex].doubleValue;
    
    for(int i = 0; i< _animationSteps; i++){
        threshold = threshold + animationSlice;
        
        NSMutableArray<NSNumber*> *valuesForGraph = [NSMutableArray array];
        NSMutableArray<UIColor*> *colorsForGraph = [NSMutableArray array];
        
        if (threshold > nextColorChange) {
            [animationValues addObject:[normalizedValues objectAtIndex:sliceIndex]];
            sliceIndex ++;
            nextColorChange = nextColorChange + [normalizedValues objectAtIndex:sliceIndex].doubleValue;
            [animationColors addObject:[_colors objectAtIndex:sliceIndex]];
            [colorsForGraph removeAllObjects];
            [colorsForGraph addObjectsFromArray:animationColors];
            [colorsForGraph addObject:_animationBackgroundColor];
        }
        
        [colorsForGraph removeAllObjects];
        [colorsForGraph addObjectsFromArray:animationColors];
        [colorsForGraph addObject:_animationBackgroundColor];
        [valuesForGraph removeAllObjects];
        [valuesForGraph addObjectsFromArray:animationValues];
        
        double visiblePerc = 0.0;
        for (NSNumber *value in valuesForGraph) {
            visiblePerc = visiblePerc+value.doubleValue;
        }
        [valuesForGraph addObject:[NSNumber numberWithDouble:(threshold-visiblePerc)]];
        [valuesForGraph addObject:[NSNumber numberWithDouble:(100.0-threshold)]];
        
        [animationImages addObject:[self generateDonutImageWithValues:valuesForGraph andColors:colorsForGraph inframe:frame withScale:scale]];
    }
    return animationImages;
}

-(UIImage *)generateDonutImageWithValues:(NSArray<NSNumber *>*)inputValues andColors:(NSArray<UIColor *>*)inputColors inframe:(CGRect)frame withScale:(CGFloat)scale
{
    YODonutChartImage* image = [[YODonutChartImage alloc] init];
    image.donutWidth = _donutWidth;
    image.values = inputValues;
    image.colors = inputColors;
    
    return [image drawImage:frame scale:scale];
}

@end
