import UIKit
import YOChartImageKit

enum YOChart {
    case SolidLineChart, SmoothLineChart, BarChart, DonutChart

    func drawImage(frame: CGRect, scale: CGFloat) -> UIImage {
        switch self {
        case .SolidLineChart:
            let image = YOLineChartImage()
            image.strokeWidth = 4.0
            image.strokeColor = randomColor()
            image.values = (0...10).map { _ in CGFloat(arc4random_uniform(8)) }
            image.smooth = false
            return image.drawImage(frame, scale: scale)
        case .SmoothLineChart:
            let image = YOLineChartImage()
            image.fillColor = randomColor()
            image.values = (0...10).map { _ in CGFloat(arc4random_uniform(8)) }
            return image.drawImage(frame, scale: scale)
        case .BarChart:
            let image = YOBarChartImage()
            image.fillColor = randomColor()
            image.strokeWidth = 2.0
            image.strokeColor = randomColor()
            image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
            return image.drawImage(frame, scale: scale)
        case .DonutChart:
            let image = YODonutChartImage()
            image.lineWidth = 16.0
            image.labelText = "LABEL"
            image.labelColor = UIColor.whiteColor()
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
