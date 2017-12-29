import WatchKit


class AnimatedDonutChartInterfaceController: BaseInterfaceController {
    
    override func didAppear() {
        super.didAppear()
        
        let chart = YOChart.AnimatedDonutChart
        let frame = CGRectMake(0, 0, contentFrame.width, contentFrame.height / 1.5)
        let imgs = chart.drawImage(frame, scale: WKInterfaceDevice.currentDevice().screenScale) as! [UIImage]
        self.imageView.setImage(UIImage.animatedImageWithImages(imgs, duration: 0.75))
        self.imageView.startAnimatingWithImagesInRange(NSRange.init(location: 0, length: imgs.count), duration: 0.75, repeatCount: 1)
    }
    
}

