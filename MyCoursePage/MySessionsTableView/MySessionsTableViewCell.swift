
import UIKit

class MySessionsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mergedButton: UIButton!
    @IBOutlet weak var absentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var leaveLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var courseTopic: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        mergedButton.layer.borderColor = UIColor.systemBlue.cgColor
        mergedButton.layer.borderWidth = 1
        mergedButton.layer.cornerRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        customView.layer.cornerRadius = 15
        contentView.layer.backgroundColor = CGColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customView.layer.masksToBounds = false
        customView.layer.shadowOffset = CGSize(width: -1, height: 1)
        customView.layer.shadowRadius = 3
        customView.layer.shadowOpacity = 0.1
    }
    
    func forAbsentLabel(model:Schedule) {
        absentLabel.isHidden = false
        switch model.status{
        case "missed":
                absentLabel.text = "Session Missed"
                absentLabel.textColor = UIColor.orange
                customView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.7).cgColor
        case "completed":
            if model.students?.first?.status?.rawValue ?? "" == "pending" || model.students?.first?.status?.rawValue ?? ""  == "absent" {
                absentLabel.text = "Absent"
                absentLabel.textColor = .systemRed
                customView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
            } else if model.students?.first?.status?.rawValue ?? ""  == "present"{
                absentLabel.text = "Present"
                absentLabel.textColor = .systemGreen
                customView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
            } else {
                absentLabel.text = model.students?.first?.status?.rawValue ?? ""
                absentLabel.textColor = .systemGreen
                customView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
            }
//        case "ongoing":
//            absentLabel.text = "Ongoing"
//            absentLabel.textColor = .black
//            customView.layer.backgroundColor = UIColor.white.cgColor
        default:            
                customView.backgroundColor = .white
                absentLabel.isHidden = true
        }
        
    }
    
}

