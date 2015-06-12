import WatchKit
import Foundation
import UIKit
import YOGraphImageKit


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var imageView: WKInterfaceImage!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)

        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()

        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 2.3)
        let scale = WKInterfaceDevice.currentDevice().screenScale

        let image = YOSimplePieChartImage()
        image.labelText = "10%"
        image.labelColor = UIColor.whiteColor()
        image.labelFont = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)

        self.imageView.setImage(image.drawImage(frame, scale: scale))
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func circleImage(frame: CGRect) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(frame.size, true, WKInterfaceDevice.currentDevice().screenScale)

        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)

        let value = 0.40 as CGFloat

        let lineWidth = CGFloat(10)
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)

        let maxLength = min(frame.size.width, frame.size.height)
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

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        CGContextRestoreGState(context)
        return image
    }

    func barChartImage(frame: CGRect) -> UIImage {
        let data: [CGFloat] = (0...9).map { _ in (CGFloat(arc4random_uniform(10) + 1) % 11) * 0.1 }

        let lineWidth = CGFloat(0)

        let dataCount = CGFloat(data.count)
        let paddingOffset = 50.0 as CGFloat
        let barPadding = ceil(1.0/CGFloat(data.count) * paddingOffset)
        let totalPadding = (dataCount - 1.0) * barPadding
        let barWidth = (frame.size.width - totalPadding) / dataCount

        UIGraphicsBeginImageContextWithOptions(frame.size, true, WKInterfaceDevice.currentDevice().screenScale)

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

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        CGContextRestoreGState(context)
        return image
    }

    func lineChartImage(frame: CGRect) -> UIImage {
        let lineWidth = CGFloat(0)

        var points: [NSValue] = (0...10).map {
            NSValue(CGPoint: CGPointMake(
                CGFloat($0) * 20,
                CGFloat(arc4random_uniform(20)))
            )
            }.reduce([NSValue](), combine: { (arr, value) in
                let lastY = arr.last?.CGPointValue().y ?? 0.0
                let append = NSValue(CGPoint: CGPointMake(value.CGPointValue().x, lastY + value.CGPointValue().y))
                return arr + [append]
            })

        let maxValue = points.map { $0.CGPointValue().y }.maxElement()!
        points = points.map { NSValue(CGPoint: CGPointMake(
            $0.CGPointValue().x,
            frame.size.height *  (1 - $0.CGPointValue().y / maxValue)
            )) }

        UIGraphicsBeginImageContextWithOptions(frame.size, true, WKInterfaceDevice.currentDevice().screenScale)

        let context = UIGraphicsGetCurrentContext()
        CGContextSaveGState(context)

        let path = quadCurvedPathWithPoints(points, frame: frame)
        path.lineWidth = lineWidth

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        CGContextRestoreGState(context)
        return image
    }

    func quadCurvedPathWithPoints(points: [NSValue], frame: CGRect) -> UIBezierPath {

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
