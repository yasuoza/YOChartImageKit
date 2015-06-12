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
        return image
    }

    func barChartImage() -> YOGraphBarChartImage {
        let image = YOGraphBarChartImage()
        image.barFillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        return image
    }

    func lineChartImage() -> YOGraphLineChartImage {
        let image = YOGraphLineChartImage()
        image.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        return image
    }

}
