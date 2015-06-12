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

        let image = YOSimpleLineChartImage()
        image.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)

        self.imageView.setImage(image.drawImage(frame, scale: scale))
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
