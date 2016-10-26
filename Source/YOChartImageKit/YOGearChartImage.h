@import UIKit;

/**
 *  A donut chart image generator provides a donut chart image without `QuartzCore.framework` and `UIView`.
 */
@interface YOGearChartImage : NSObject

/**
 *  The value for the gear chart. Must be an NSNumber.
 */
@property (nonnull, nonatomic) NSNumber *value;

/**
 *  The color for the gear chart.
 */
@property (nonnull, nonatomic) UIColor *color;

/**
 *  The color for the unfilled chart.
 */
@property (nonnull, nonatomic) UIColor *backgroundColor;

/**
 *  The alpha for the unfilled chart.
 */
@property (nonatomic) CGFloat backgroundColorAlpha;

/**
 *  The point where the donut starts
 *  The default width is `-M_PI_2`, which means the degree 0 of the circle.
 */
@property (nonatomic) CGFloat startAngle;

/**
 *  The width of donut.
 *  The default width is `1.0`.
 */
@property (nonatomic) CGFloat gearWidth;

/**
 *  The text of center label in donut chart.
 *  The default text is `nil`.
 */
@property (nullable, nonatomic, copy) NSString *labelText;

/**
 *  The color of center label in donut chart.
 *  The default color is black.
 */
@property (nonnull, nonatomic) UIColor *labelColor;

/**
 *  The font of center label in donut chart.
 *  The default font is UIFont with UIFontTextStyleBody.
 */
@property (nonnull, nonatomic) UIFont *labelFont;

/**
 *  Draws a image of donut chart.
 *
 *  @param frame The frame rectangle for the chart image.
 *  @param scale The scale factor for chart image.
 *
 *  @return An donut chart drawed `UIImage` object.
 */
- (UIImage * _Nonnull)drawImage:(CGRect)frame scale:(CGFloat)scale;

@end
