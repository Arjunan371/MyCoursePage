
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
        customView.layer.cornerRadius = 10
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
        switch model.status{
        case "missed":
            absentLabel.text = "Session Missed"
            absentLabel.textColor = .black
            customView.layer.backgroundColor = UIColor.white.withAlphaComponent(0.8).cgColor
            print("")
        case "completed":
            if model.students?.first?.status?.rawValue ?? "" == "pending" || model.students?.first?.status?.rawValue ?? ""  == "absent" {
                customView.layer.backgroundColor = CGColor(red: 243/255, green: 253/255, blue: 237/255, alpha: 1)
             //   contentView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
                absentLabel.text = "Absent"
                absentLabel.textColor = .systemRed
            } else if model.students?.first?.status?.rawValue ?? ""  == "present" {
                absentLabel.text = "Present"
                absentLabel.textColor = .systemGreen
                customView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
             //   contentView.layer.backgroundColor = CGColor(red: 243/255, green: 254/255, blue: 237/255, alpha: 1)
            }
            print("")
        case "ongoing":
            absentLabel.text = "Ongoing"
            absentLabel.textColor = .black
            print("")
        default:
            absentLabel.isHidden = true
            customView.backgroundColor = .white
            print("")
        }
        
    }
    
}

