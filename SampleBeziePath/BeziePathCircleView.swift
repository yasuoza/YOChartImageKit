import UIKit

public class BeziePathCircleView: UIView {

    override public func drawRect(rect: CGRect) {
        let value = 0.10 as CGFloat

        let lineWidth = CGFloat(20)
        let center = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)

        let maxLength = min(self.bounds.width, self.bounds.height)
        let radius = maxLength / 2 - lineWidth / 2

        let overallContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(overallContext)

        let overallpath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat(M_PI_2),
            endAngle: CGFloat(M_PI_2) * 3,
            clockwise: true
        )
        overallpath.lineWidth = lineWidth
        UIColor.whiteColor().colorWithAlphaComponent(0.4).setStroke()
        overallpath.stroke()
        CGContextRestoreGState(overallContext)

        let pathContext = UIGraphicsGetCurrentContext()
        CGContextSaveGState(pathContext)
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: -CGFloat(M_PI_2),
            endAngle: -CGFloat(M_PI_2) + 2 * CGFloat(M_PI) * value,
            clockwise: true
        )
        path.lineWidth = lineWidth
        UIColor.clearColor().setFill()
        path.fill()
        UIColor.whiteColor().setStroke()
        path.stroke()
        CGContextRestoreGState(pathContext)
    }

}
