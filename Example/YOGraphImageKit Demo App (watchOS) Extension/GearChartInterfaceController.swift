import WatchKit


class GearChartInterfaceController: BaseInterfaceController {
    
    override func didAppear() {
        super.didAppear()
        
        let chart = YOChart.GearChart
        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        let image = chart.drawImage(frame, scale: WKInterfaceDevice.currentDevice().screenScale) as! UIImage
        self.imageView.setImage(image)
    }
    
}
