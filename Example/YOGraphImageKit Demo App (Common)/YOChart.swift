import UIKit
import YOChartImageKit

enum YOChart {
    case SolidLineChart, SmoothLineChart, VerticalBarChart, HorizontalBarChart, DonutChart, SolidLineChartGradient, SmoothLineChartGradient, VerticalBarChartGradient, GearChart

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
            image.values = [4.0, 5.0, -3.0, -1.0, 3.5]
            return image.drawImage(frame, scale: scale)
        case .VerticalBarChart:
            let image = YOBarChartImage()
            image.fillColor = randomColor()
            image.barPadding = 2.0
            image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
            return image.drawImage(frame, scale: scale)
        case .HorizontalBarChart:
            let image = YOBarChartImage()
            image.fillColor = randomColor()
            image.barPadding = 2.0
            image.barStyle = .Horizontal
            image.values = (0..<8).map { _ in CGFloat(arc4random_uniform(50) + 1) }
            return image.drawImage(frame, scale: scale)
        case .DonutChart:
            let image = YODonutChartImage()
            image.donutWidth = 16.0
            image.labelText = "LABEL"
            image.labelColor = UIColor.whiteColor()
            image.values = [10.0, 20.0, 70.0]
            image.colors = (0..<3).map { _ in randomColor() }
            return image.drawImage(frame, scale: scale)
        case .SolidLineChartGradient:
            let image = YOLineChartImage()
            image.strokeWidth = 0.0
            image.gradientFill = true
            image.firstGradientColor = randomColor()
            image.secondGradientColor = randomColor()
            image.values = (0...10).map { _ in CGFloat(arc4random_uniform(8)) }
            image.smooth = false
            return image.drawImage(frame, scale: scale)
        case .SmoothLineChartGradient:
            let image = YOLineChartImage()
            image.strokeWidth = 1.0
            image.strokeColor = UIColor.whiteColor()
            image.gradientFill = true
            image.firstGradientColor = UIColor.whiteColor()
            image.secondGradientColor = randomColor()
            image.values = (0...10).map { _ in CGFloat(arc4random_uniform(8)) }
            image.smooth = true
            return image.drawImage(frame, scale: scale)
        case .VerticalBarChartGradient:
            let image = YOBarChartImage()
            image.onlyPositiveBars = true
            image.positiveColor = UIColor.whiteColor()
            image.positiveGradientColor = UIColor.greenColor()
            image.negativeColor = UIColor.whiteColor()
            image.negativeGradientColor = UIColor.redColor()
            image.barPadding = 20.0
            image.roundedCaps = true
            image.capsCornerRadius = 10.0
            image.values = [4.0, 5.0, -3.0, -1.0, 3.5]
            return image.drawImage(frame, scale: scale)
        case .GearChart:
            let image = YOGearChartImage()
            image.gearWidth = 10.0
            image.labelText = "80%"
            image.labelColor = UIColor.whiteColor()
            image.value = 80.0
            image.color = randomColor()
            image.backgroundColor = image.color
            image.backgroundColorAlpha = 0.2
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
