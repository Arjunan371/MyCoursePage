import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var searchBar1: UISearchBar!
    @IBOutlet weak var academicYearLabel: UILabel!
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
    @IBOutlet weak var myCourseTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        searchBar1.isHidden = true
        allButton.tintColor = .systemBlue
        academicYearLabel.text = "Academic Year: 2025 - 2026"
        viewModel.showAcademicDataIndicator = {
            self.activityIndicator.showActivityIndicator(uiView: self.view)
        }
        viewModel.forInitialApiIntegration(){
            self.viewModel.filteredData()
            self.myCourseTableView.reloadData()
            self.activityIndicator.hideActivityIndicator()
        }
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
    }
    
    func forCornerRadius() {
        searchButton.layer.cornerRadius = 15
        toStartButton.layer.cornerRadius = 15
        completeButton.layer.cornerRadius = 15
        progressButton.layer.cornerRadius = 15
        allButton.layer.cornerRadius = 15
    }
    
    @IBAction func academicYearButton(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "academic") as? AcademicYearViewController
        vc?.didSelectAcadamicYear = { [self] (academicYear,academicModel) in
            self.academicYearLabel.text = "Academic Year: \(academicYear)"
            self.viewModel.forInitialApiIntegration(academicModel: academicModel){
                self.viewModel.showAcademicDataIndicator = {
                    self.activityIndicator.showActivityIndicator(uiView: self.view)
                }
                self.viewModel.filteredData(searchText: self.searchBar1.text ?? "")
                self.myCourseTableView.reloadData()
                self.activityIndicator.hideActivityIndicator()
            }
            viewModel.filteredData(searchText: self.searchBar1.text ?? "")
        }
        self.present(vc!, animated: true)
    }
    
    @IBAction func toStartAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 1
        toStartButton.tintColor = .systemBlue
        allButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        completeButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        progressButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        viewModel.filteredData(searchText: searchBar1.text ?? "")
        myCourseTableView.reloadData()
        toStartButton.backgroundColor = .white
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func completedAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 2
        toStartButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        allButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        completeButton.tintColor = .systemBlue
        progressButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        viewModel.filteredData(searchText: searchBar1.text ?? "")
        myCourseTableView.reloadData()
        completeButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func progressAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 3
        toStartButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        allButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        completeButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        progressButton.tintColor = .systemBlue
        viewModel.filteredData(searchText: searchBar1.text ?? "")
        myCourseTableView.reloadData()
        progressButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        allButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func allAction(_ sender: UIButton) {
        viewModel.filterButtonIndex = 4
        toStartButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        allButton.tintColor = .systemBlue
        completeButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        progressButton.tintColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        viewModel.filteredData(searchText: searchBar1.text ?? "")
        myCourseTableView.reloadData()
        allButton.backgroundColor = .white
        toStartButton.backgroundColor = .white.withAlphaComponent(0.3)
        progressButton.backgroundColor = .white.withAlphaComponent(0.3)
        completeButton.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    @IBAction func sideMenuButtonAction(_ sender: UIButton) {
        let sideMenuViewController = storyboard?.instantiateViewController(withIdentifier: "sideMenuViewController") as! sideMenuViewController
        sideMenuViewController.modalPresentationStyle = .overCurrentContext
        presentFromLeftToRight(sideMenuViewController)
    }
    
    func presentFromLeftToRight(_ viewControllerToPresent: UIViewController) {
        viewControllerToPresent.view.frame = CGRect(x: -viewControllerToPresent.view.frame.width, y: 0, width: viewControllerToPresent.view.frame.width, height: viewControllerToPresent.view.frame.height)

        // Add the new view controller as a child
        addChild(viewControllerToPresent)
        view.addSubview(viewControllerToPresent.view)
        viewControllerToPresent.didMove(toParent: self)

        // Animate the presentation
        UIView.animate(withDuration: 0.1) {
            viewControllerToPresent.view.frame = self.view.bounds
        }
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        searchBar1.searchTextField.backgroundColor = .white.withAlphaComponent(0.5)
                searchBar1.searchBarStyle = .minimal
                searchBar1.backgroundColor = .clear
                searchBar1.tintColor = .white
                searchBar1.showsCancelButton = true
                searchBar1.isUserInteractionEnabled = true
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
        cell.downArrow.addTarget(self, action: #selector(downArrowButton), for: .touchUpInside)
        cell.topicLabel.text = "\(myCouse.courseName ?? "")"
        cell.dateLabel.text = "\(myCouse.term ?? "") - \(myCouse.level ?? "")/\(DateFromWebtoApp(myCouse.startDate ?? ""))/\(DateFromWebtoApp(myCouse.endDate ?? ""))"
        if myCouse.downArrow {
            cell.view3.isHidden = false
            cell.view2.isHidden = false
            cell.view3.layer.cornerRadius = 10
            cell.downArrow.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            cell.attendanceDetailLabel.text = "Attendance Detail"
            cell.warningButton.setTitle("Denial", for: .normal)
            cell.sessionAttendLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.attendedSessions ?? 0) )/ \(doubleDigitString(from: myCouse.sessionData?.completedSessions ?? 0) ) Sessions Attented"
            cell.sessionAttendBelowLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.leaveCount ?? 0) ) Leave . \(doubleDigitString(from: myCouse.sessionData?.absentCount ?? 0) ) Absent"
            cell.inProgressLabel.text = "\(doubleDigitString(from: myCouse.sessionData?.completedSessions ?? 0) )/ \(doubleDigitString(from: myCouse.sessionData?.totalSessions ?? 0) ) Sessions Completed"
            if cell.view2.isHidden == false {
                cell.warningButton.setTitle("Denial", for: .normal)
            }
        }
        else {
            cell.view2.isHidden = true
            cell.view3.isHidden = true
            cell.downArrow.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        if myCouse.sessionData?.completedSessions == 0 {
            cell.view2.isHidden = true
        }
        if myCouse.downArrow {
            if myCouse.sessionData?.totalSessions == 0 || myCouse.sessionData?.completedSessions == 0{
                cell.sessionsCompletedLabel.text = "To Start"
                cell.sessionsCompletedLabel.textColor = .systemRed
            } else if myCouse.sessionData?.completedSessions ?? 0 > 0 {
                cell.sessionsCompletedLabel.text = "In Progress"
                cell.sessionsCompletedLabel.textColor = .black
            } else if myCouse.sessionData?.totalSessions == myCouse.sessionData?.completedSessions  {
                cell.sessionsCompletedLabel.text = "Completed"
                cell.sessionsCompletedLabel.textColor = .systemGreen
            }
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
                let totalValue = Float(myCouse.sessionData?.completedSessions ?? 0)
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

    }
    
    @objc func downArrowButton(sender: UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: myCourseTableView)
        guard let indexPath = myCourseTableView.indexPathForRow(at: btnPos) else {
            return }
        
        let cellData = viewModel.dataCourseListModel[indexPath.row]
        
        if cellData.downArrow {
            if let index = viewModel.indexOf(course: cellData ) {
                viewModel.courseData[index].downArrow = false
            }
        } else {
            self.viewModel.showIndicator = {
                self.activityIndicator.showActivityIndicator(uiView: self.view)
            }
            viewModel.forApiIntegration(course: cellData){
                self.activityIndicator.hideActivityIndicator()
                if let index = self.viewModel.indexOf(course: cellData) {
                    self.viewModel.courseData[index].downArrow = true
                }
                self.viewModel.filteredData(searchText: self.searchBar1.text ?? "")
                self.myCourseTableView.reloadData()
            }
        }
        self.viewModel.filteredData(searchText: self.searchBar1.text ?? "")
        myCourseTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MySessionsTabBarController") as! MySessionsTabBarController
        let model = viewModel.courseData[indexPath.row]
        vc.myCourseModel = model
        self.navigationController?.pushViewController(vc, animated: true)
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
        viewModel.filteredData()
        searchBar.resignFirstResponder()
        searchBar1.isHidden = true
        myCourseTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filteredData(searchText: searchText)
        self.myCourseTableView.reloadData()
    }
}

