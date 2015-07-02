import UIKit
import YOChartImageKit

enum ChartType {
    case LineChart, BarChart, DonutChart

    func drawImage(frame: CGRect) -> UIImage {
        let scale = UIScreen.mainScreen().scale
        switch self {
        case .LineChart:
            let image = YOLineChartImage()
            image.fillColor = randomColor().colorWithAlphaComponent(0.4)
            image.strokeWidth = 2.0
            image.strokeColor = randomColor()
            image.values = (0...10).map { _ in
                CGFloat(arc4random_uniform(8))
            }
            return image.drawImage(frame, scale: scale)
        case .BarChart:
            let image = YOBarChartImage()
            image.barFillColor = randomColor()
            image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
            return image.drawImage(frame, scale: scale)
        case .DonutChart:
            let image = YODonutChartImage()
            image.lineWidth = 16.0
            image.labelText = "LABEL"
            image.labelColor = UIColor.whiteColor()
            image.labelFont = UIFont.systemFontOfSize(32)
            image.values = [10.0, 20.0, 70.0]
            image.colors = (0..<3).map { _ in randomColor() }
            return image.drawImage(frame, scale: scale)
        }
    }

    private func randomColor() -> UIColor {
        let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
        let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
        let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
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
