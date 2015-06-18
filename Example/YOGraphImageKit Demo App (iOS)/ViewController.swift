import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {

    private weak var pageViewController: UIPageViewController!

    let chartTypes: [ChartType] = [.LineChart, .BarChart, .DonutChart]

    override func viewDidLoad() {
        super.viewDidLoad()

        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        pageController.dataSource = self

        let vc = self.getItemController(0)!
        pageController.setViewControllers([vc], direction: .Forward, animated: false, completion: nil)

        self.pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)

        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {

        let chartImageVC = viewController as! ChartImageViewController
        if let currentIndex = chartTypes.indexOf(chartImageVC.chartType) {
            let beforeIndex = Int(currentIndex) - 1
            return getItemController(beforeIndex)
        }
        return nil
    }

    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {

        let chartImageVC = viewController as! ChartImageViewController
        if let currentIndex = chartTypes.indexOf(chartImageVC.chartType) {
            let afterIndex = Int(currentIndex) + 1
            return getItemController(afterIndex)
        }
        return nil
    }

    func getItemController(itemIndex: Int) -> ChartImageViewController? {
        guard itemIndex >= 0 && itemIndex < 3 else { return nil }

        let types: [ChartType] = [.LineChart, .BarChart, .DonutChart]
        let chartImageVC = self.storyboard!.instantiateViewControllerWithIdentifier("ChartImageViewController") as! ChartImageViewController

        chartImageVC.chartType = types[itemIndex]
        return chartImageVC
    }

    // MARK: - Page Indicator

    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

