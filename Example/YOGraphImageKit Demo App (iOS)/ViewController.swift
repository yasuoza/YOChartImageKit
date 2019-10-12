import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    private weak var pageViewController: UIPageViewController!

    let charts: [YOChart] = [.SolidLineChart, .SmoothLineChart, .VerticalBarChart, .HorizontalBarChart, .DonutChart]

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageController = self.storyboard!.instantiateViewController(withIdentifier: "PageController") as! UIPageViewController
        pageController.dataSource = self

        let vc = self.getItemController(itemIndex: 0)!
        pageController.setViewControllers([vc], direction: .forward, animated: false, completion: nil)

        self.pageViewController = pageController
        addChild(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMove(toParent: self)

        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.gray
        appearance.currentPageIndicatorTintColor = UIColor.white
        appearance.backgroundColor = UIColor.darkGray
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let chartImageVC = viewController as! ChartImageViewController
        if let currentIndex = charts.firstIndex(of: chartImageVC.chart) {
            let beforeIndex = Int(currentIndex) - 1
            return getItemController(itemIndex: beforeIndex)
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let chartImageVC = viewController as! ChartImageViewController
        if let currentIndex = charts.firstIndex(of: chartImageVC.chart) {
            let afterIndex = Int(currentIndex) + 1
            return getItemController(itemIndex: afterIndex)
        }
        return nil
    }

    func getItemController(itemIndex: Int) -> ChartImageViewController? {
        guard itemIndex >= 0 && itemIndex < charts.count else { return nil }

        let chartImageVC = self.storyboard!.instantiateViewController(withIdentifier: "ChartImageViewController") as! ChartImageViewController
        chartImageVC.chart = charts[itemIndex]
        return chartImageVC
    }

    // MARK: - Page Indicator

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return charts.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

