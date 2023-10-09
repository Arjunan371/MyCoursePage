import UIKit

class MySessionsViewController: UIViewController {
    
    @IBOutlet weak var warningImage: UIImageView!
    @IBOutlet weak var denialLabel: UILabel!
    @IBOutlet weak var denialView: UIView!
    @IBOutlet weak var warningView: UIView!
    @IBOutlet weak var warningLabel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var attendanceSessionsLabel: UILabel!
    @IBOutlet weak var attendanceLabel: UILabel!
    @IBOutlet weak var courseTopicLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var MySessionsTableView: UITableView!
    @IBOutlet weak var MySessionsCollectionView: UICollectionView!
    let activityIndica = ActivityIndicator()
    let viewModel = MySessionViewModel()
    var courseModel:Datum? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let flowLayout = MySessionsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        backView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        view.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        MySessionsTableView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        MySessionsTableView.register(UINib(nibName: "MySessionsTableViewCell", bundle: nil), forCellReuseIdentifier: "MySessionsTableViewCell")
        MySessionsCollectionView.register(UINib(nibName: "MyCourseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MyCourseCollectionView")
        
        warningView.isHidden = true
        denialView.isHidden = true

            viewModel.forMySessionCollectionApi(course: courseModel){
                self.viewModel.selectedTab = 1
                self.MySessionsCollectionView.reloadData()
                self.viewModel.showAcademicDataIndicator = {
                    self.activityIndica.showActivityIndicator(uiView: self.view)
                }
                self.viewModel.forMySessionTableViewApi(SessionType: self.viewModel.MySessionTableDatas.first?.schedules?.first?.type ?? "regular",course: self.courseModel){ sessionModel in
                    let sessionData = sessionModel.data?.first
                    self.courseTopicLabel.text = "\(self.courseModel?.programName ?? "")"
                    self.courseNameLabel.text = "\(self.courseModel?.courseName ?? "")"
                    let firstValue = sessionData?.attendedSessions ?? 0
                    let totalValue = sessionData?.completedSessions ?? 0
                    self.attendanceLabel.text = "Attendace"
                    if totalValue > 0 {
                        let progress = (Float(firstValue) / Float(totalValue))
                        let attendance = self.roundToSingleDecimalDigit(progress * 100)
                        self.progressLabel.text = "\(self.formatPercentage(attendance))%"
                        self.attendanceSessionsLabel.text = "\(firstValue)/\(totalValue) Sessions"
                    } else {
                        self.attendanceSessionsLabel.text = "00 / 00"
                        self.progressLabel.text = "-"
                    }
                    let absentDetail = self.roundToSingleDecimalDigit(Float(sessionData?.absentPercentage ?? 0))
                    self.warningLabel.text = "\(self.formatPercentage(absentDetail)) %"
                    if self.viewModel.mySessionCollectionData.first?.type == "all"{
                        if sessionData?.warningData != "" {
                            self.denialView.isHidden = false
                            self.warningView.isHidden = false
                            self.denialLabel.text = sessionData?.warningData ?? ""
                        }
                    } else {
                        self.denialView.isHidden = true
                        self.warningView.isHidden = true
                    }
                    if self.denialLabel.text == "Denial"{
                        self.warningImage.image = UIImage(named: "warning")
                    } else {
                        self.warningImage.image = UIImage(named: "warning1")
                    }
                    self.MySessionsTableView.reloadData()
                    self.activityIndica.hideActivityIndicator()
                }
            }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        }
    
    func roundToSingleDecimalDigit(_ floatValue: Float) -> Float {
        return round(floatValue * 10.0) / 10.0
    }
    
    @IBAction func MysSessionBackButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MySessionsViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.mySessionCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCourseCollectionView", for: indexPath) as! MyCourseCollectionViewCell
        let buttonData = viewModel.mySessionCollectionData[indexPath.row]
        let buttonDetail = "\(buttonData.name ?? "")(\(buttonData.count ?? 0))"
        cell.buttonLabel.text = buttonDetail
        cell.mySessionTopButtons.addTarget(self, action: #selector(mySessionTopButtonAction), for: .touchUpInside)
        if viewModel.selectedTab == indexPath.item {
            cell.buttonLabel.tintColor = .systemBlue
            cell.customView.backgroundColor = .white
        } else {
            cell.customView.backgroundColor = .white.withAlphaComponent(0.5)
            cell.buttonLabel.textColor = .black
        }
        return cell
    }
    @objc func mySessionTopButtonAction(sender: UIButton) {
        let btnPos = sender.convert(CGPoint.zero, to: MySessionsCollectionView)
        guard let indexPath = MySessionsCollectionView.indexPathForItem(at: btnPos) else {
            return }
        let cellData = viewModel.mySessionCollectionData[indexPath.row]
        viewModel.showAcademicDataIndicator = { [self] in
            self.activityIndica.showActivityIndicator(uiView: view)
        }

        viewModel.forMySessionTableViewApi(SessionType: cellData.type ?? "",course: courseModel){sessionModel in
            let sessionData = sessionModel.data?.first
            self.courseTopicLabel.text = "\(self.courseModel?.programName ?? "")"
            self.courseNameLabel.text = "\(self.courseModel?.courseName ?? "")"
            let firstValue = Float(sessionData?.attendedSessions ?? 0)
            let totalValue = Float(sessionData?.completedSessions ?? 0)
            if totalValue > 0 {
                let progress = firstValue / totalValue
                let attendance = self.roundToSingleDecimalDigit((progress * 100))
                self.progressLabel.text = "\(self.formatPercentage(attendance))%"
                self.attendanceLabel.text = "Attendace"
                self.attendanceSessionsLabel.text = "\(self.doubleDigitString(from: sessionData?.attendedSessions ?? 0)) / \(self.doubleDigitString(from:sessionData?.completedSessions ?? 0)) Sessions"
            } else {
                self.attendanceSessionsLabel.text = "00 / 00"
                self.progressLabel.text = "-"
            }

            let absentDetail = self.roundToSingleDecimalDigit(Float(sessionData?.absentPercentage ?? 0))
            self.warningLabel.text = "\(self.formatPercentage(absentDetail)) %"
            if self.viewModel.mySessionCollectionData[indexPath.row].type == "all"{
                if sessionData?.warningData != "" {
                    self.denialView.isHidden = false
                    self.warningView.isHidden = false
                    self.denialLabel.text = sessionData?.warningData ?? ""
                }
            } else {
                self.denialView.isHidden = true
                self.warningView.isHidden = true

            }
            if self.denialLabel.text == "Denial"{
                self.warningImage.image = UIImage(named: "warning")
            } else {
                self.warningImage.image = UIImage(named: "warning1")
            }
            if self.viewModel.MySessionTableDatas.count > 0 {
                let indexPath = IndexPath(row: 0, section: 0)
                self.MySessionsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            self.MySessionsTableView.reloadData()
            self.activityIndica.hideActivityIndicator()
        }
        viewModel.selectedTab = indexPath.item
        MySessionsCollectionView.reloadData()
        
    }
    
    func doubleDigitString(from intValue: Int) -> String {
        return String(format: "%02d", intValue)
    }
    
    static func storyboard(_ name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
    
    static func getViewController<T>(type: T.Type, storyboard: String) -> T {
        let identifies = String(describing: T.self)
        let vc = self.storyboard(storyboard).instantiateViewController(withIdentifier: identifies) as! T
        return vc
    }
    
}

extension MySessionsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.MySessionTableDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MySessionsTableViewCell", for: indexPath) as! MySessionsTableViewCell
        let myCourseData = viewModel.MySessionTableDatas[indexPath.row]
        if let scheduleModel = myCourseData.schedules?.first {
            cell.forAbsentLabel(model: scheduleModel )
        }
        if myCourseData.mergeWith?.count == nil {
            if myCourseData.schedules?.first?.type == "regular"{
                cell.courseTopic.text =  "\(myCourseData.deliverySymbol ?? "" )\(myCourseData.deliveryNo ?? 0 ) - \(myCourseData.sessionTopic ?? "")"
                
            } else {
                cell.courseTopic.text =  "\(myCourseData.schedules?.first?.subType ?? "" ) - \(myCourseData.sessionTopic ?? "")"
            }
            cell.mergedButton.isHidden = true
        } else {
            for index in 0..<(myCourseData.mergeWith?.count ?? 0){
                cell.courseTopic.text  = "\(myCourseData.deliverySymbol ?? "" )\(myCourseData.deliveryNo ?? 0 ),   \(myCourseData.mergeWith?[index].session?.deliverySymbol?.rawValue ?? "")\(myCourseData.mergeWith?[index].session?.deliveryNo ?? 0)"
            }
            cell.mergedButton.isHidden = false
        }
        var studentGroups = ""
        for index in 0..<(myCourseData.schedules?.first?.studentGroups?.count ?? 0) {
            if myCourseData.schedules?.first?.type == "regular" {
                studentGroups += "\((myCourseData.schedules?.first?.studentGroups?[index].groupName ?? "").suffix(4))(\((myCourseData.schedules?.first?.studentGroups?[index].sessionGroup?.first?.groupName ?? "").suffix(3))),"
            } else {
                studentGroups += "\((myCourseData.schedules?.first?.studentGroups?[index].groupName ?? "")),"
            }
        }
        studentGroups = String(studentGroups.dropLast())
        cell.levelLabel.text = studentGroups
        cell.leaveLabel.text = "\(myCourseData.schedules?.first?.courseName ?? "") • \(myCourseData.schedules?.first?.mode?.rawValue ?? "") • \(myCourseData.schedules?.first?.infraName ?? "")"
        cell.timeLabel.text = " \(DateFromWebtoApp(myCourseData.schedules?.first?.scheduleDate ?? "")), \(myCourseData.schedules?.first?.start?.hour ?? 0):\(myCourseData.schedules?.first?.start?.minute ?? 0) \(myCourseData.schedules?.first?.start?.format?.rawValue ?? "") - \(myCourseData.schedules?.first?.end?.hour ?? 0):\(myCourseData.schedules?.first?.end?.minute ?? 0) \(myCourseData.schedules?.first?.end?.format?.rawValue ?? "")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(identifier: "SessionTabBarController") as! SessionTabBarController
        let myCourseData = viewModel.MySessionTableDatas[indexPath.row]
        vc.tableModel = myCourseData
        vc.courseModelData = courseModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "dd MMM yyyy"
        return  dateFormatter.string(from: date!)
    }
    
    func forSessonType(_ IntValue: Int) -> String {
        if viewModel.mySessionCollectionData.first?.count == 0 {
            let intValue = self.viewModel.MySessionTableDatas.first?.schedules?.first?.type ?? "regular"
            return "\(intValue)"
        } else {
            return "\(viewModel.mySessionCollectionData.first?.type ?? "today")"
        }
    }
    
    func formatPercentage(_ floatValue: Float) -> String {
        if floatValue.truncatingRemainder(dividingBy: 1) == 0 {
            let intValue = Int(floatValue)
            return "\(intValue)"
        } else {
            return "\(floatValue)"
        }
    }
    
}
