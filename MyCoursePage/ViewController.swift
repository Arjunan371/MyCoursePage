//
//  ViewController.swift
//  MyCoursePage
//
//  Created by Arjunan on 08/09/23.
//

import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var myCourseLabel: UILabel!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var academicYearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var allButton: UIButton!
    @IBOutlet weak var progressButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var toStartButton: UIButton!
    let viewModel = MyCourseVieModel()
    public var activityIndicator = ActivityIndicator()
    var cellDataLoad: (() ->())?
    @IBOutlet weak var myCourseTableView: UITableView!
    
    var searchBar1: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        searchBar.searchTextField.backgroundColor = .white.withAlphaComponent(0.5)
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundColor = .clear
        searchBar.tintColor = .white
        searchBar.showsCancelButton = true
        searchBar.isUserInteractionEnabled = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        myCourseTableView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        allButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
        
        forCornerRadius()
        myCourseTableView.register(UINib(nibName: "MyCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "MyCourseTableViewCell")
        myCourseTableView.delegate = self
        myCourseTableView.dataSource = self
        // viewModel.forAppendDataInModel()
    }
    
    func constraintForSearchBar() {
        view.addSubview(searchBar1)
        
        NSLayoutConstraint.activate([
            searchBar1.topAnchor.constraint(equalTo: searchButton.topAnchor),
            searchBar1.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor,constant: 5),
            searchBar1.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor,constant: -5),
            searchBar1.bottomAnchor.constraint(equalTo: searchButton.bottomAnchor),
        ])
    }
    
    func forCornerRadius() {
        searchButton.layer.cornerRadius = 15
        toStartButton.layer.cornerRadius = 10
        completeButton.layer.cornerRadius = 10
        progressButton.layer.cornerRadius = 10
        allButton.layer.cornerRadius = 10
    }
    
    @IBAction func academicYearButton(_ sender: UIButton) {
        performSegue(withIdentifier: "academic", sender: self)
    }
    
    @IBAction func toStartAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 1
        //  viewModel.filteredData()
        toStartButton.backgroundColor = .white
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func completedAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 2
        //   viewModel.filteredData()
        completeButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func progressAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 3
        // viewModel.filteredData()
        progressButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func allAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 4
        // viewModel.filteredData()
        allButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        constraintForSearchBar()
        viewModel.filteredData()
        myCourseLabel.isHidden = true
        searchBar1.isHidden = false
        searchBar1.delegate = self
        searchBar1.becomeFirstResponder()
        searchButton.isHidden = true
    }
}
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataCourseListModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCourseTableViewCell", for: indexPath) as! MyCourseTableViewCell
        let myCouse = viewModel.dataCourseListModel[indexPath.row]
        
        cell.topicLabel.text = "\(myCouse.courseName ?? "")"
        cell.dateLabel.text = "\(myCouse.term ?? "") - \(myCouse.level ?? "")/\(DateFromWebtoApp(myCouse.startDate ?? ""))/\(DateFromWebtoApp(myCouse.startDate ?? ""))"
        
        cell.downArrow.addTarget(self, action: #selector(downAroowButton), for: .touchUpInside)
        if myCouse.downArrow {
            cell.view2.isHidden = false
            cell.view3.isHidden = false
            cell.downArrow.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            cell.attendanceDetailLabel.text = "Attendance Detail"
            cell.sessionAttendLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.attendedSessions ?? 0) )/ \(doubleDigitString(from: myCouse.sessionData?.completedSessions ?? 0) ) Sessions Attented"
            cell.sessionAttendBelowLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.leaveCount ?? 0) ) Leave . \(doubleDigitString(from: myCouse.sessionData?.absentCount ?? 0) ) Absent"
            cell.inProgressLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.completedSessions ?? 0) )/ \(doubleDigitString(from: myCouse.sessionData?.totalSessions ?? 0) ) Sessions Completed"
            cell.warningButton.setTitle("\(myCouse.sessionData?.warningData ?? "" )", for: .normal)
        }
        else {
            cell.view2.isHidden = true
            cell.view3.isHidden = true
            cell.downArrow.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        if myCouse.sessionData?.completedSessions == 0 {
            cell.view2.isHidden = true
        }
        if myCouse.sessionData?.totalSessions == 0 || myCouse.sessionData?.completedSessions == 0{
            cell.sessionsCompletedLabel.text = "To Start"
            cell.sessionsCompletedLabel.textColor = .systemRed
        } else if myCouse.sessionData?.totalSessions == myCouse.sessionData?.completedSessions  {
            cell.sessionsCompletedLabel.text = "Completed"
            cell.sessionsCompletedLabel.textColor = .systemGreen
        } else {
            cell.sessionsCompletedLabel.text = "In Progress"
            cell.sessionsCompletedLabel.textColor = .black
        }
        if myCouse.downArrow {
            let firstValue = Float(myCouse.sessionData?.completedSessions ?? 0)
            let totalValue = Float(myCouse.sessionData?.totalSessions ?? 0)
            if totalValue > 0 {
                let progress = firstValue / totalValue
                cell.progressView.progress = progress
            } else {
                cell.progressView.progress = 0
            }
            if myCouse.downArrow {
                let firstValue = Float(myCouse.sessionData?.attendedSessions ?? 0)
                let lastValue = Float(myCouse.sessionData?.completedSessions ?? 0)
                if  totalValue > 0 {
                    let progress = firstValue / totalValue
                    cell.forCircularView(setprogres: progress)
                    let attendance = roundToSingleDecimalDigit(progress * 100)
                    cell.circularViewLabel.text = "\(attendance)%"
                } else {
                    cell.forCircularView(setprogres: 0)
                }
            }
        }
        
        return cell
        //        cell.attendanceDetailLabel.text = myCouse.attendanceDetails
        //        cell.sessionAttendLabel.text = myCouse.sessionsAttend
        //        cell.sessionAttendBelowLabel.text = myCouse.leave
        //        cell.sessionsCompletedLabel.text = myCouse.completed
        //        cell.inProgressLabel.text = myCouse.sessionsComplete
        
        /*     if cell.inProgressLabel.text == "00/ 52 Sessions Completed" {
         cell.sessionsCompletedLabel.text = "To Start"
         cell.sessionsCompletedLabel.textColor = .systemRed
         cell.warningButton.isHidden = true
         cell.progressView.tintColor = .systemGray
         cell.progressView.progress = 0
         } else if cell.inProgressLabel.text == "52/ 52 Sessions Completed" {
         cell.sessionsCompletedLabel.text = "Completed"
         cell.sessionsCompletedLabel.textColor = .systemGreen
         cell.progressView.tintColor = .systemGreen
         cell.progressView.progress = 1
         } else {
         let progressValue: Float = 40
         let clampedProgress = min(max(progressValue, 0), 52)
         cell.progressView.progress = clampedProgress / 52.0
         cell.sessionsCompletedLabel.text = "InProgress"
         }
         
         if cell.sessionAttendLabel.text == "00/ 52 Sessions Attended"  {
         cell.circularViewLabel.text = "0%"
         cell.view2.isHidden = true
         cell.forCircularView(setprogres: 0)
         } else if cell.sessionAttendLabel.text == "52/ 52 Sessions Attended" {
         cell.circularViewLabel.text = "100%"
         cell.forCircularView(setprogres: 1)
         } else {
         let attendance = Int ((40.0/52.0) * 100)
         cell.circularViewLabel.text = "\(attendance)%"
         cell.forCircularView(setprogres: 40/52)
         } */
        //  let myCouseBelowData = viewModel.myCourseBelowData
    }
    @objc func downAroowButton(sender: UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: myCourseTableView)
        guard let indexPath = myCourseTableView.indexPathForRow(at: btnPos) else {
            return }
        
        if viewModel.dataCourseListModel[indexPath.row].downArrow {
            viewModel.dataCourseListModel[indexPath.row].downArrow = false
        } else {
            viewModel.dataCourseListModel[indexPath.row].downArrow = true
            viewModel.showIndicator = {
                self.activityIndicator.showActivityIndicator(uiView: self.view)
            }
        }
        
        if  viewModel.dataCourseListModel[indexPath.row].downArrow {
            let courseModel = viewModel.dataCourseListModel[indexPath.row]
            viewModel.forApiIntegration(course: courseModel,id: courseModel.id ?? "", institutionCalendarId: courseModel.institutionCalendarID ?? "", courseType: courseModel.courseType ?? "", level: courseModel.level ?? "", term: courseModel.term ?? "",rotation: courseModel.rotation ?? "",rotationCount: courseModel.rotationCount ?? 0){
                self.activityIndicator.hideActivityIndicator()
                self.myCourseTableView.reloadData()
            }
        }
        myCourseTableView.reloadData()
    }
    
    func roundToSingleDecimalDigit(_ floatValue: Float) -> Float {
        return round(floatValue * 10.0) / 10.0
    }
    
    func doubleDigitString(from intValue: Int) -> String {
        return String(format: "%02d", intValue)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy."
        return  dateFormatter.string(from: date!)
    }
    
}
extension ViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        myCourseLabel.isHidden = false
        searchBar1.isHidden = true
        searchButton.isHidden = false
        searchBar1.text = ""
        searchBar.resignFirstResponder()
        searchBar1.isHidden = true
        myCourseTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData(searchText: searchText)
        self.myCourseTableView.reloadData()
    }
}
