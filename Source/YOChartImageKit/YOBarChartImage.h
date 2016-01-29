@import UIKit;

/**
 *  A bar chart image generator provides a bar chart image without `QuartzCore.framework` and `UIView`.
 */
@interface YOBarChartImage : NSObject

/** @name Data Types **/

/**
 *  Defines the stylistic appearance of different types of images.
 */
typedef NS_ENUM(NSInteger, YOBarChartImageBarStyle){
    /**
     *  Use the vertical growing style.
     */
    YOBarChartImageBarStyleVertical,
    /**
     *  Use the horizontal growing style.
     */
    YOBarChartImageBarStyleHorizontal
};

/** @name Bar chart rendering properties */

/**
 *  The array of values for the bar chart. `values` should be an array of NSNumber.
 *  You must provide `values`, otherwise raises an exception.
 */
@property (nonnull, nonatomic) NSArray<NSNumber *> *values;

/**
 *  The maximum value to use for the chart. Setting this will override the 
 *  default behavior of using the highest value as maxValue.
 */
@property (nonnull, nonatomic) NSNumber* maxValue;

/**
 *  The style of the bar chart.
 */
@property (nonatomic) YOBarChartImageBarStyle barStyle;

/**
 *  The padding of each bars.
 *  The default padding is automatically calculated by count of values.
 *  Use this property when you want to set the bar padding explicitly.
 */
@property (nonatomic) CGFloat barPadding;

/**
 *  The width of chart's stroke.
 *  The default width is `0.0`.
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

/** @name Drawing a chart **/

/**
 *  Draws a image of bar chart.
 *
 *  @param frame The frame rectangle for the chart image.
 *  @param scale The scale factor for chart image.
 *
 *  @return An bar chart drawed `UIImage` object.
 */
- (UIImage * _Nonnull)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
