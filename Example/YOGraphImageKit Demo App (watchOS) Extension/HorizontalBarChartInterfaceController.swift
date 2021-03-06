import WatchKit


class HorizontalBarChartInterfaceController: BaseInterfaceController {

    override func willActivate() {
        super.willActivate()

        let chart = YOChart.HorizontalBarChart
        let frame = CGRect(x: 0, y: 0, width: contentFrame.width, height: contentFrame.height / 1.5)
        let image = chart.drawImage(frame: frame, scale: WKInterfaceDevice.current().screenScale)
        self.imageView.setImage(image)
    }
    
}
