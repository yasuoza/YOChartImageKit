#import "YODonutChartImage.h"
@import UIKit;

/**
 *  A _spinning_ variant of `YODonutChartImage`.
 */
@interface YOSpinningDonutChartImage : YODonutChartImage

/**
 *  The spinner will automatically create a gradient, based on the last color
 *  Default is `true`
 */
@property BOOL useGradient;

/**
 *  The array of colors for the donut chart. `colors` should be an array of UIColor.
 *  You must provide `colors`, otherwise raises an exception.
 */
@property (nonatomic) UIColor *color;

/**
 *  One value is enough — the `values` will fill the rest.
 *  The default is 70
 */
@property (assign, nonatomic) CGFloat value;

/**
 *  The duration of the spinning animation
 *  The default value is 2 seconds.
 */
@property CGFloat duration;

@end
