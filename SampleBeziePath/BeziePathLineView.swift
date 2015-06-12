import UIKit

public class BeziePathLineView: UIView {

    override public func drawRect(rect: CGRect) {
        let lineWidth = CGFloat(0)

        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)

        let points: [NSValue] = (0...10).map {
            NSValue(CGPoint: CGPointMake(
                CGFloat($0) * 20,
                CGFloat(arc4random_uniform(20)))
            )
            }.reduce([NSValue](), combine: { (arr, value) in
                let lastY = arr.last?.CGPointValue().y ?? 0.0
                let append = NSValue(CGPoint: CGPointMake(value.CGPointValue().x, lastY + value.CGPointValue().y))
                return arr + [append]
            }).map {
                NSValue(CGPoint: CGPointMake($0.CGPointValue().x, frame.size.height - $0.CGPointValue().y))
        }

        let path = quadCurvedPathWithPoints(points)
        path.lineWidth = lineWidth

        CGContextRestoreGState(context)
    }

    func quadCurvedPathWithPoints(points: [NSValue]) -> UIBezierPath {

        let path = UIBezierPath()

        let fillBottom = UIBezierPath()
        let startPonit = CGPointMake(0, frame.size.height)
        let endPoint = CGPointMake(frame.size.width, frame.size.height)
        fillBottom.moveToPoint(endPoint)
        fillBottom.addLineToPoint(startPonit)

        var p1 = points[0].CGPointValue()
        path.moveToPoint(p1)

        // FillBottom
        fillBottom.addLineToPoint(p1)

        if points.count == 2 {
            let value = points[1]
            let p2 = value.CGPointValue()
            path.addLineToPoint(p2)
            return path
        }

        for var i = 1; i < points.count; i++ {
            let value = points[i]
            let  p2 = value.CGPointValue()

            let deltaX = p2.x - p1.x
            let controlPointX = p1.x + (deltaX/2)

            let controlPoint1 = CGPointMake(controlPointX, p1.y)
            let controlPoint2 = CGPointMake(controlPointX, p2.y)

            path.addQuadCurveToPoint(p2, controlPoint: controlPoint2)

            // FillBottom
            fillBottom.addCurveToPoint(
                p2,
                controlPoint1: controlPoint1,
                controlPoint2: controlPoint2
            )

            p1 = p2
        }
        
        // FillBottom
        UIColor.whiteColor().colorWithAlphaComponent(0.6).setFill()
        fillBottom.fill()
        
        return path
    }
}
