//
//  ThirdSessionTableViewCell.swift
//  MyCoursePage
//
//  Created by Arjunan on 06/10/23.
//

import UIKit

class ThirdSessionTableViewCell: UITableViewCell {

    @IBOutlet weak var absentIMageButton: UIButton!
    @IBOutlet weak var absentImage1: UIImageView!
    @IBOutlet weak var absentLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var staffName: UILabel!
    @IBOutlet weak var staff: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
//        customView.layer.cornerRadius = 15
        mainView.layer.cornerRadius = 15
        bottomView.backgroundColor = .clear
        customView.backgroundColor = .clear
        moreInfoButton.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        moreInfoButton.layer.borderColor = UIColor.systemBlue.cgColor
        moreInfoButton.layer.borderWidth = 2
        moreInfoButton.setTitle("More Info", for: .normal)
        moreInfoButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        moreInfoButton.semanticContentAttribute = .forceRightToLeft
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        mainView.layer.masksToBounds = false
        mainView.layer.shadowOffset = CGSize(width: -1, height: 1)
        mainView.layer.shadowRadius = 3
        mainView.layer.shadowOpacity = 0.1
    }
    
    func sessionConfigure(model: SessionModelData) {
        dateLabel.text = "\(DateFromWebtoApp(model.schedules?.first?.scheduleDate ?? "")), \(model.schedules?.first?.start?.hour ?? 0) : \(model.schedules?.first?.start?.minute ?? 00) \(model.schedules?.first?.start?.format ?? "") - \(model.schedules?.first?.end?.hour ?? 0) : \(model.schedules?.first?.end?.minute ?? 00) \(model.schedules?.first?.end?.format ?? "")"
        var studentGroups = ""
        for index in 0..<(model.schedules?.first?.studentGroups?.count ?? 0) {
            if model.schedules?.first?.type == "regular" {
                studentGroups += "\((model.schedules?.first?.studentGroups?[index].groupName ?? "").suffix(4))(\((model.schedules?.first?.studentGroups?[index].sessionGroup?.first?.groupName ?? "").suffix(3))),"
             } else {
                studentGroups += "\((model.schedules?.first?.studentGroups?[index].groupName ?? "")),"
            }
        }
        studentGroups = String(studentGroups.dropLast())
        groupLabel.text = studentGroups
        programLabel.text = "\(model.schedules?.first?.courseName ?? "") • \(model.schedules?.first?.mode ?? "") • \(model.schedules?.first?.infraName ?? "-")"
        staff.text = "Staff"
        staffName.text = "\(model.schedules?.first?.staffs?.first?.staffName?.first ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.middle ?? "") \(model.schedules?.first?.staffs?.first?.staffName?.last ?? "")"
        if model.schedules?.first?.mode ?? "" == "onsite" {
            absentIMageButton.setImage(UIImage(systemName: "exclamationmark.circle.fill"), for: .normal)
            absentIMageButton.tintColor = .lightGray
        }

    }


    
func forAbsentLabel(model:SessionSchedule) {
    
    switch model.status{
    case "missed":
        absentLabel.text = "Session Missed"
        absentLabel.textColor = .systemOrange
    case "completed":
        if model.students?.first?.status ?? "" == "present" {
            absentLabel.text = "Attendance Marked Successfully"
            absentLabel.textColor = .systemGreen
            absentImage1.image = UIImage(systemName: "checkmark.circle.fill")
            absentImage1.tintColor = .systemGreen
        } else {
            absentLabel.text = "Attendance Marked Absent"
            absentLabel.textColor = .systemRed
            absentImage1.image = UIImage(systemName: "xmark.circle.fill")
            absentImage1.tintColor = .systemRed
        }
    default:
        absentLabel.text = "-"
        absentLabel.textColor = .systemOrange
    }
    
}

func DateFromWebtoApp(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let date = dateFormatter.date(from: date)
    dateFormatter.dateFormat = "MMM dd, yyyy"
    return  dateFormatter.string(from: date!)
}
}
