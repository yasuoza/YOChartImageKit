import UIKit
import YOGraphImageKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let scale = UIScreen.mainScreen().scale

        imageView.image = pieChartImage().drawImage(imageView.frame, scale: scale)
    }

    func pieChartImage() -> YOGraphPieChartImage {
        let image = YOGraphPieChartImage()
        image.lineWidth = 8.0
        image.labelText = "10.0%"
        image.labelColor = UIColor.whiteColor()
        image.values = [10.0, 20.0, 70.0]
        image.colors = (0..<3).map { _ in
            let hue = ( CGFloat(arc4random() % 256) / 256.0 )               //  0.0 to 1.0
            let saturation = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from white
            let brightness = ( CGFloat(arc4random() % 128) / 256.0 ) + 0.5  //  0.5 to 1.0, away from black
            return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        }
        return image
    }

    func barChartImage() -> YOGraphBarChartImage {
        let image = YOGraphBarChartImage()
        image.barFillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        image.values = (0..<15).map { _ in CGFloat(arc4random_uniform(50) + 1) }
        return image
    }

    func lineChartImage() -> YOGraphLineChartImage {
        let image = YOGraphLineChartImage()
        image.fillColor = UIColor.whiteColor().colorWithAlphaComponent(0.6)
        image.values = (0...10).map { _ in
            CGFloat(arc4random_uniform(50))
            }.reduce([CGFloat](), combine: { (arr: [CGFloat], value) in
                let lastY = arr.last ?? 0.0
                return arr + [lastY + value]
            })
        return image
    }

}

