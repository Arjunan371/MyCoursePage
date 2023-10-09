
import UIKit

class SessionViewController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var sessionTableView: UITableView!
    
    let viewModel = SessionViewModel()
    var tableModel:SessionElement? = nil
    var courseModel:Datum? = nil
    var sessionTabBar = SessionTabBarController()
    var indicator = ActivityIndicator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        sessionTableView.register(UINib(nibName: "SessionTableViewCell", bundle: nil), forCellReuseIdentifier: "SessionTableViewCell")
        sessionTableView.register(UINib(nibName: "SecondSessionTableViewCell", bundle: nil), forCellReuseIdentifier: "SecondSessionTableViewCell")
        sessionTableView.register(UINib(nibName: "ThirdSessionTableViewCell", bundle: nil), forCellReuseIdentifier: "ThirdSessionTableViewCell")
        viewModel.showAcademicIndicator = {
            self.indicator.showActivityIndicator(uiView: self.view)
        }
        viewModel.forSessionApiIntegration(course: courseModel,mySession: tableModel){ sessionData in
            let modelData = sessionData.data?.first
            if modelData?.schedules?.first?.type == "regular" {
                self.label1.text = "\(modelData?.schedules?.first?.session?.deliverySymbol ?? "")\(modelData?.schedules?.first?.session?.deliveryNo ?? 0) \(modelData?.schedules?.first?.session?.sessionTopic ?? "")"
            } else {
                self.label1.text = "\(modelData?.schedules?.first?.subType ?? "") - \(modelData?.sessionTopic ?? "")"
            }
            self.label2.text = "\(modelData?.programName ?? "")"
            self.sessionTableView.reloadData()
            self.indicator.hideActivityIndicator()
        }
        sessionTableView.delegate = self
        sessionTableView.dataSource = self
        
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension SessionViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.sessionTableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = viewModel.sessionTableData[indexPath.row]
        if model.isSelected {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondSessionTableViewCell", for: indexPath) as! SecondSessionTableViewCell
            cell.sessionConfigure(model: model)
            cell.closeButton.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
                return cell
        } else {
            if model.schedules?.first?.status == "completed" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdSessionTableViewCell", for: indexPath) as! ThirdSessionTableViewCell
                if let model = viewModel.sessionTableData.first?.schedules?.first {
                    cell.forAbsentLabel(model: model)
                }
                cell.sessionConfigure(model: model)
                cell.moreInfoButton.addTarget(self, action: #selector(completedAction), for: .touchUpInside)
               return cell
               
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SessionTableViewCell", for: indexPath) as! SessionTableViewCell
                cell.moreInfoButton.addTarget(self, action: #selector(moreInfoButtonAction), for: .touchUpInside)
                cell.sessionConfigure(model: model)
               return cell
            }
        }
    }
    
    @objc func completedAction(sender:UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: sessionTableView)
        guard let indexPath = sessionTableView.indexPathForRow(at: btnPos) else {
            return }
        let model = viewModel.sessionTableData[indexPath.row]
        if viewModel.sessionTableData[indexPath.row].isSelected {
            viewModel.sessionTableData[indexPath.row].isSelected = false
        } else {
            viewModel.sessionTableData[indexPath.row].isSelected = true
        }
        sessionTableView.reloadData()
    }
    
    @objc func moreInfoButtonAction(sender:UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: sessionTableView)
        guard let indexPath = sessionTableView.indexPathForRow(at: btnPos) else {
            return }
        let model = viewModel.sessionTableData[indexPath.row]
        if viewModel.sessionTableData[indexPath.row].isSelected {
            viewModel.sessionTableData[indexPath.row].isSelected = false
        } else {
            viewModel.sessionTableData[indexPath.row].isSelected = true
        }
        sessionTableView.reloadData()
    }
    
    @objc func closeButtonAction(sender:UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: sessionTableView)
        guard let indexPath = sessionTableView.indexPathForRow(at: btnPos) else {
            return }
        let model = viewModel.sessionTableData[indexPath.row]
        if viewModel.sessionTableData[indexPath.row].isSelected {
            viewModel.sessionTableData[indexPath.row].isSelected = false
        } else {
            viewModel.sessionTableData[indexPath.row].isSelected = true
        }
        sessionTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
