import UIKit
import YOChartImageKit

enum ChartType {
    case LineChart, BarChart, DonutChart

    func drawImage(frame: CGRect) -> UIImage {
        let scale = UIScreen.mainScreen().scale
        switch self {
        case .LineChart:
            let image = YOLineChartImage()
            image.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            image.values = (0...10).map { _ in
                CGFloat(arc4random_uniform(50))
                }.reduce([CGFloat](), combine: { (arr: [CGFloat], value) in
                    let lastY = arr.last ?? 0.0
                    return arr + [lastY + value]
                })
            return image.drawImage(frame, scale: scale)
        case .BarChart:
            let image = YOBarChartImage()
            image.barFillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
            image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
            return image.drawImage(frame, scale: scale)
        case .DonutChart:
            let image = YODonutChartImage()
            image.lineWidth = 16.0
            image.labelText = "LABEL"
            image.labelColor = UIColor.whiteColor()
            image.labelFont = UIFont.systemFontOfSize(32)
            image.values = [10.0, 20.0, 70.0]
            image.colors = (0..<3).map { _ in
                let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
                let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
                let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
                return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
            }
            return image.drawImage(frame, scale: scale)
        }

    }
}

class ChartImageViewController: UIViewController {

    var chartType = ChartType.LineChart

    @IBOutlet weak var imageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        imageView.image = chartType.drawImage(self.imageView.frame)
    }
}
