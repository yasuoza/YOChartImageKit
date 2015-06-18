import WatchKit
import Foundation


class BarChartInterfaceController: BaseInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        self.imageView.setImage(barChartImage(frame))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
