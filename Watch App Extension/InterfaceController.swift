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

        self.imageView.setImage(lineChartImage().drawImage(frame, scale: scale))
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func pieChartImage() -> YOGraphPieChartImage {
        let image = YOGraphPieChartImage()
        image.lineWidth = 8.0
        image.labelText = "10.0%"
        image.labelColor = UIColor.whiteColor()
        image.values = [10.0, 20.0, 70.0]
        image.colors = (0..<3).map { _ in
            let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
            let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
            let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        }
        return image
    }

    func barChartImage() -> YOGraphBarChartImage {
        let image = YOGraphBarChartImage()
        image.barFillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
        return image
    }

    func lineChartImage() -> YOGraphLineChartImage {
        let image = YOGraphLineChartImage()
        image.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        image.values = (0...10).map { _ in
            CGFloat(arc4random_uniform(50))
        }.reduce([CGFloat](), combine: { (arr: [CGFloat], value) in
            let lastY = arr.last ?? 0.0
            return arr + [lastY + value]
        })
        return image
    }

}
