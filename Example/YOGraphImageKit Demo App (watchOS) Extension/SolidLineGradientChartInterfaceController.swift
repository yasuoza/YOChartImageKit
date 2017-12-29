import WatchKit


class SolidLineGradientChartInterfaceController: BaseInterfaceController {

    override func didAppear() {
        super.didAppear()

        let chart = YOChart.SolidLineChartGradient
        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        let image = chart.drawImage(frame, scale: WKInterfaceDevice.currentDevice().screenScale) as! UIImage
        self.imageView.setImage(image)
    }

}
