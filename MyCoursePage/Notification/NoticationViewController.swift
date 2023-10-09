
import UIKit

class NoticationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var notificationTableView: UITableView!
    let viewModel = NotificationViewModel()
    var activity = ActivityIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        notificationTableView.delegate = self
        notificationTableView.dataSource = self
        view.layer.backgroundColor = CGColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        notificationTableView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        activity.showActivityIndicator(uiView: self.view)
        viewModel.forNotificationTableView(limit: 10, pageNo: 1){
            self.notificationTableView.reloadData()
            self.activity.hideActivityIndicator()
        }
        notificationTableView.register(UINib(nibName: "NotificationTableViewCell", bundle: nil), forCellReuseIdentifier: "NotificationTableViewCell")
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTableViewCell",for: indexPath) as! NotificationTableViewCell
        let model = viewModel.modelData[indexPath.row]
        cell.hourLabel.text = "\(model.timeAgo ?? "")"
        cell.titleLabel.text = "\(model.title ?? "")"
        cell.feedBackLabel.text = "\(model.description ?? "")"
        if model.type == "activity" {
            cell.sessionLabelText.text = "Go To Activity"
        } else {
            cell.sessionLabelText.text = "Go To Session"
        }
       
        cell.sessionLabel.addTarget(self, action: #selector(goToSessionAction), for: .touchUpInside)
        return cell
    }
    
    @objc func goToSessionAction(sender: UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: notificationTableView)
        guard let indexPath = notificationTableView.indexPathForRow(at: btnPos) else {
            return }
        let model = viewModel.modelData[indexPath.row]

        if model.type == "activity" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SessionTabBarController") as! SessionTabBarController
            vc.modalPresentationStyle = .fullScreen
            vc.selectedIndex = 1
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "SessionTabBarController") as! SessionTabBarController
            vc.modalPresentationStyle = .fullScreen
            vc.selectedIndex = 0
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



