import UIKit

class ChartImageViewController: UIViewController {

    var chart = YOChart.SolidLineChart

    @IBOutlet weak var imageView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        imageView.image = chart.drawImage(frame: self.imageView.frame, scale: UIScreen.main.scale)
    }
}
