

import UIKit

class sideMenuViewController: UIViewController {

    @IBOutlet weak var sideMenuTableView: UITableView!
    @IBOutlet weak var customView: UIView!
    
    let viewModel = NotificationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        sideMenuTableView.register(UINib(nibName: "sideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "sideMenuTableViewCell")
        sideMenuTableView.delegate = self
        sideMenuTableView.dataSource = self
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.customViewAction))
        self.customView.addGestureRecognizer(gesture)
    }
 
    @objc func customViewAction(sender : UITapGestureRecognizer) {
        dismissFromRightToLeft()
    }

    func dismissFromRightToLeft() {
        // Animate the dismissal
        UIView.animate(withDuration: 0.2, animations: {
            self.view.frame.origin.x = -self.view.frame.size.width
        }) { (finished) in
            // Remove the view controller from the parent
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
        }
    }

}

extension sideMenuViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sideMenuTableViewCell", for: indexPath) as! sideMenuTableViewCell
        cell.sideMenuLabel.text = viewModel.data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let notificationController = storyboard?.instantiateViewController(withIdentifier: "NoticationViewController") as! NoticationViewController
        notificationController.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(notificationController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



