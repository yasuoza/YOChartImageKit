import WatchKit


class SolidLineChartInterfaceController: BaseInterfaceController {

    override func willActivate() {
        super.willActivate()

        let chart = YOChart.SolidLineChart
        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        let image = chart.drawImage(frame, scale: WKInterfaceDevice.currentDevice().screenScale)
        self.imageView.setImage(image)
    }

}
