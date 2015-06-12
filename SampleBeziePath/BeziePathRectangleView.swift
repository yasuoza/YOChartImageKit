import UIKit

public class BeziePathRectangleView: UIView {

    let paddingOffset = 50.0 as CGFloat

    override public func drawRect(rect: CGRect) {
        let data: [CGFloat] = (0...9).map { _ in (CGFloat(arc4random_uniform(10) + 1) % 11) * 0.1 }

        let lineWidth = CGFloat(0)
        self.backgroundColor = UIColor.clearColor()

        let dataCount = CGFloat(data.count)
        let barPadding = ceil(1.0/CGFloat(data.count) * paddingOffset)
        let totalPadding = (dataCount - 1.0) * barPadding
        let barWidth = (frame.size.width - totalPadding) / dataCount

        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)

        for var i = 0; i < data.count; i++ {
            let value = data[i]
            let rect = CGRectMake(
                CGFloat(i) * (barWidth + barPadding),
                frame.size.height * (1.0 - value),
                barWidth,
                frame.size.height / value
            )
            let path = UIBezierPath(rect: rect)
            path.lineWidth = lineWidth
            UIColor.whiteColor().colorWithAlphaComponent(0.6).setFill()
            path.fill()
        }

        CGContextRestoreGState(context)
    }

}
