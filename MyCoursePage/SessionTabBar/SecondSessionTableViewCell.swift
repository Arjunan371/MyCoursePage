
import UIKit

class SecondSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionDetailLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var fourteenthLabel: UILabel!
    @IBOutlet weak var thirteenthLabel: UILabel!
    @IBOutlet weak var twelvethLabel: UILabel!
    @IBOutlet weak var leventhLabel: UILabel!
    @IBOutlet weak var tenthLabel: UILabel!
    @IBOutlet weak var ninethLabel: UILabel!
    @IBOutlet weak var eightLabel: UILabel!
    @IBOutlet weak var seventhLabel: UILabel!
    @IBOutlet weak var sixthLabel: UILabel!
    @IBOutlet weak var fifthLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var firstLabel: UILabel!

    @IBOutlet weak var customView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        closeButton.layer.cornerRadius = 15
        customView.layer.cornerRadius = 15
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        customView.layer.masksToBounds = false
        customView.layer.shadowOffset = CGSize(width: -1, height: 1)
        customView.layer.shadowRadius = 3
        customView.layer.shadowOpacity = 0.1
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func isSelectedTrue() {
        lastLabel.textColor = .black
        firstLabel.textColor = .black
        secondLabel.textColor = .black
        thirdLabel.textColor = .black
        fourthLabel.textColor = .black
        fifthLabel.textColor = .black
        sixthLabel.textColor = .black
        seventhLabel.textColor = .black
        eightLabel.textColor = .black
        ninethLabel.textColor = .black
        tenthLabel.textColor = .black
        leventhLabel.textColor = .black
        twelvethLabel.textColor = .black
        thirteenthLabel.textColor = .black
        fourteenthLabel.textColor = .black
        sessionDetailLabel.textColor = .black

    }
//    func isSelectedFalse() {
//        firstLabel.superview?.isHidden = true
//        ninethLabel.superview?.isHidden = true
//        twelvethLabel.superview?.isHidden = true
//        thirteenthLabel.superview?.isHidden = true
//        fourteenthLabel.superview?.isHidden = true
//        lastLabel.superview?.isHidden = true
//    }
    
    func sessionConfigure(model:SessionModelData) {

            customView.backgroundColor = .systemBlue
        closeButton.setTitle("Close", for: .normal)
            closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
                closeButton.semanticContentAttribute = .forceRightToLeft
           closeButton.layer.borderWidth = 0
            firstLabel.text = "-"
            secondLabel.text = "Topic Name"
            thirdLabel.text = "\(model.programName ?? "-")"
            fourthLabel.text = "Student Groups"
            var studentGroups = ""
            for index in 0..<(model.schedules?.first?.studentGroups?.count ?? 0) {
                if model.schedules?.first?.type == "regular" {
                    studentGroups += "\((model.schedules?.first?.studentGroups?[index].groupName ?? "").suffix(4))(\((model.schedules?.first?.studentGroups?[index].sessionGroup?.first?.groupName ?? "").suffix(3))),"
                } else {
                    studentGroups += "\((model.schedules?.first?.studentGroups?[index].groupName ?? "")),"
                }
            }
            studentGroups = String(studentGroups.dropLast())
            fifthLabel.text = studentGroups
            sixthLabel.text = "Duration"
            seventhLabel.text = "\(model.schedules?.first?.staffs?.first?.staffName?.first ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.middle ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.last ?? "")"
            eightLabel.text = "Subject"
            ninethLabel.text = "\(model.schedules?.first?.subjects?.first?.subjectName ?? "")"
            tenthLabel.text = "Mode"
           leventhLabel.text = "\(model.schedules?.first?.mode ?? "")"
            twelvethLabel.text = "Staff"
            thirteenthLabel.text = "\(model.schedules?.first?.staffs?.first?.staffName?.first ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.middle ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.last ?? "")"
            fourteenthLabel.text = "Infra"
            lastLabel.text = "\(model.schedules?.first?.infraName ?? "")"
    }
        
    func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: date!)
    }
    
}
