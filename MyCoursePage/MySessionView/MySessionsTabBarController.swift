import UIKit

class MySessionsTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    let viewModel = MySessionViewModel()
    var myCourseModel: Datum? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        self.delegate = self
        for childVC in self.viewControllers ?? [] {
            if let sessionVC = childVC as? MySessionsViewController {
                sessionVC.courseModel = myCourseModel
            }
        }
    }

}
