import UIKit

class AcademicYearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backgroundView: UIView!
    let viewModel = MyCourseVieModel()
    @IBOutlet weak var academicTableView: UITableView!
    var didSelectAcadamicYear: ((String,AcademicData) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.academicYearApiIntegration(){
            self.academicTableView.reloadData()
        }
        backgroundView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        academicTableView.backgroundColor =  UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        academicTableView.register(UINib(nibName: "AcademicTableViewCell", bundle: nil), forCellReuseIdentifier: "AcademicTableViewCell")
        academicTableView.delegate = self
        academicTableView.dataSource = self

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.academicData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademicTableViewCell", for: indexPath) as! AcademicTableViewCell
        let academicData = viewModel.academicData[indexPath.row]
        cell.academicLabel.text = "\(academicData.calendarName) (\(DateFromWebtoApp(academicData.startDate)) - \(DateFromWebtoApp(academicData.endDate))) (Inactive)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "myCourse") as! ViewController
        let academicData = viewModel.academicData[indexPath.row]
//        vc.academicYearData = "\(academicYear(academicData.startDate )) - \(academicYear(academicData.endDate))"
        //print("academicYearData==>","\(academicYear(academicData.startDate )) - \(academicYear(academicData.endDate))")
        didSelectAcadamicYear?("\(academicYear(academicData.startDate )) - \(academicYear(academicData.endDate))",academicData)
        self.dismiss(animated: true)
    }
        
    func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy."
        return  dateFormatter.string(from: date!)
    }
    
    func academicYear(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "yyyy"
        return  dateFormatter.string(from: date!)
    }

}
