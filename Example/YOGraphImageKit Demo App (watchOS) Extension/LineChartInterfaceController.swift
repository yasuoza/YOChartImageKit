import WatchKit


class LineChartInterfaceController: BaseInterfaceController {

    override func willActivate() {
        super.willActivate()

        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        self.imageView.setImage(lineChartImage(frame))
    }

}
