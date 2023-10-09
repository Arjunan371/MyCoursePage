
import UIKit

class SessionTabBarController: UITabBarController, UITabBarControllerDelegate {

    var tableModel:SessionElement? = nil
    var courseModelData:Datum? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        tabBar.unselectedItemTintColor = .white.withAlphaComponent(0.5)
        self.delegate = self
        for childVC in self.viewControllers ?? [] {
            if let sessionVC = childVC as? SessionViewController {
                sessionVC.tableModel = tableModel
                sessionVC.courseModel = courseModelData
            }
        }
    }

}
