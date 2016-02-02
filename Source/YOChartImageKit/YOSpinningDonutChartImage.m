#import "YOSpinningDonutChartImage.h"

@implementation YOSpinningDonutChartImage {
  CGFloat startAngle;
  NSMutableArray *images;
  NSInteger index;
}

- (instancetype)init {
    self = [super init];
    if (self) {
      index = 0;
      _duration = 2;
    }
    return self;
}

- (UIImage *)drawImage:(CGRect)frame scale:(CGFloat)scale {
    while (index++ < 32) {
      self.startAngle = startAngle;
      CGFloat chunk = M_PI_4 / 4;
      if (startAngle > (M_PI + M_PI_2 - chunk)) {
        startAngle = -M_PI_2;
      } else {
        startAngle += chunk;
      }
      UIImage *image = [super drawImage:frame scale:scale];
      if (!images) {
        images = [NSMutableArray arrayWithObject:image];
      } else {
        [images addObject:image];
      }
    }
    UIImage *image = [UIImage animatedImageWithImages:images duration:_duration];
    return image;
}

@end
