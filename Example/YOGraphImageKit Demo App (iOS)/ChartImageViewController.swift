import UIKit

class ChartImageViewController: UIViewController {

    var chart = YOChart.SolidLineChart

    @IBOutlet weak var imageView: UIImageView!

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        imageView.image = chart.drawImage(self.imageView.frame, scale: UIScreen.mainScreen().scale)
    }
}
