@import UIKit;

/**
 *  A bar chart image generator provides a bar chart image without `QuartzCore.framework` and `UIView`.
 */
@interface YOBarChartImage : NSObject

/** @name Bar chart rendering properties */

/**
 *  The array of values for the bar chart. `values` should be an array of NSNumber.
 *  You must provide `values`, otherwise raises an exception.
 */
@property (nonnull) NSArray<NSNumber *> *values;

/**
 *  The padding of each bars.
 *  The default padding is automatically calculated by count of values.
 *  Use this property when you want to set the bar padding explicitly.
 */
@property CGFloat barPadding;

/**
 *  The width of chart's stroke.
 *  The default width is `0.0`.
 */
@property CGFloat strokeWidth;

/**
 *  The color of chart's stroke.
 *  The default color is whiteColor.
 */
@property (nullable) UIColor *strokeColor;

/**
 *  The color of chart's area.
 *  The default color is `nil`.
 */
@property (nullable) UIColor *fillColor;

/** @name Drawing a chart **/

/**
 *  Draws a image of bar chart.
 *
 *  @param frame The frame rectangle for the chart image.
 *  @param scale The scale factor for chart image.
 *
 *  @return An bar chart drawed `UIImage` object.
 */
- (__nonnull UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
