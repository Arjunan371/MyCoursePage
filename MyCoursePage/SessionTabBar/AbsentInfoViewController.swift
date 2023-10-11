//
//  AbsentInfoViewController.swift
//  MyCoursePage
//
//  Created by Arjunan on 10/10/23.
//

import UIKit

class AbsentInfoViewController: UIViewController {
    
    var tableModel:SessionElement? = nil
    var sessionModel: SessionModelData? = nil
    var topicName: String?
    var status: String?
    var time: String?
    var topivLevel: String?
    
    let viewModel = SessionViewModel()
    
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var absentTableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var absentLabel: UILabel!
    @IBOutlet weak var attendaceStatus: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var popUpViewHeight: NSLayoutConstraint!
    var absentDataclosure: (()-> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.layer.cornerRadius = 15
        absentTableView.register(UINib(nibName: "PopUpTableViewCell", bundle: nil), forCellReuseIdentifier: "PopUpTableViewCell")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        absentLabel.layer.cornerRadius = 8
        absentLabel.clipsToBounds = true
        absentLabel.textColor = .systemRed
        absentTableView.delegate = self
        absentTableView.dataSource = self
        if tableModel?.mergeStatus == true {
            topicLabel.text = "\(topicName ?? "") \(topivLevel ?? "")"
        } else {
            topicLabel.text = "\(topicName ?? "")"
        }
        
        viewModel.forAttendaceInfo(mySession: sessionModel){
       //     let model = self.viewModel.attendaceModelDatas
            if self.status == "absent" {
                self.absentLabel.text = "Absent"
            } else {
                self.absentLabel.text = "Present"
                self.absentLabel.backgroundColor = .systemGreen.withAlphaComponent(0.2)
                self.absentLabel.textColor = .systemGreen
            }
            
            self.absentLabel.backgroundColor = .systemRed.withAlphaComponent(0.2)
            self.attendaceStatus.text = "Attendance Status"
          //  self.topicLabel.text = self.topicName
            self.absentTableView.reloadData()
        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension AbsentInfoViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.attendaceModelDatas.count > 1 {
            return viewModel.attendaceModelDatas.count
        } else {
            return 1
        }
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopUpTableViewCell", for: indexPath) as! PopUpTableViewCell
       
        if viewModel.attendaceModelDatas.count > 1 {
            let model = viewModel.attendaceModelDatas[indexPath.row]
            if indexPath.row == 0 {
                cell.createdTime.text = "Latest - \(DateFromWebtoApp(model.createdAt ?? "") ?? "")"
            } else {
                cell.createdTime.text = "\(DateFromWebtoApp(model.createdAt ?? "") ?? "")"
            }
            popUpViewHeight.constant = 600
            cell.modeByLabel.text = "\(model.modeBy ?? "")"
            if model.students?.status == "present" {
                cell.attendanceImage.image = UIImage(systemName: "checkmark.circle.fill")
                cell.attendanceImage.tintColor = .systemGreen
            } else {
                cell.attendanceImage.image = UIImage(systemName: "xmark.circle.fill")
                cell.attendanceImage.tintColor = .systemRed
            }
        } else {
            popUpViewHeight.constant = 220
            cell.modeByLabel.text = "Primary"
            cell.createdTime.text = "Latest - \(DateFromWebtoApp(time ?? "") ?? "")"
            if status == "present" {
                cell.attendanceImage.image = UIImage(systemName: "checkmark.circle.fill")
                cell.attendanceImage.tintColor = .systemGreen
            } else {
                cell.attendanceImage.image = UIImage(systemName: "xmark.circle.fill")
                cell.attendanceImage.tintColor = .systemRed
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func DateFromWebtoApp(_ date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "h:mm a"
        return  dateFormatter.string(from: date ?? Date())
    }
    
    
}
