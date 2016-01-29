@import UIKit;

/**
 *  A line chart image generator provides a line chart image without `QuartzCore.framework` and `UIView`.
 */
@interface YOLineChartImage : NSObject

/** @name Line chart rendering properties */

/**
 *  The array of values for the line chart. `values` should be an array of NSNumber.
 *  You must provide `values`, otherwise raises an exception.
 */
@property (nonnull, nonatomic) NSArray<NSNumber *> *values;

/**
 *  The maximum value to use for the chart. Setting this will override the
 *  default behavior of using the highest value as maxValue.
 */
@property (nonnull, nonatomic) NSNumber* maxValue;

/**
 *  The width of chart's stroke. 
 *  The default width is `1.0`.
 */
@property (nonatomic) CGFloat strokeWidth;

/**
 *  The color of chart's stroke. 
 *  The default color is whiteColor.
 */
@property (nullable, nonatomic) UIColor *strokeColor;

/**
 *  The color of chart's area. 
 *  The default color is `nil`.
 */
@property (nullable, nonatomic) UIColor *fillColor;

/**
 *  `YES` draws smooth line chart, `NO` draws a straight line chart.
 *  The default value is `YES`
 */
@property (nonatomic) BOOL smooth;

/** @name Drawing a chart **/

/**
 *  Draws a image of line chart.
 *
 *  @param frame The frame rectangle for the chart image.
 *  @param scale The scale factor for chart image.
 *
 *  @return An line chart drawed `UIImage` object.
 */
- (UIImage * _Nonnull)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
