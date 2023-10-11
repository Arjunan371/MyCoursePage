//
//  SessionTableViewCell.swift
//  MyCoursePage
//
//  Created by Arjunan on 04/10/23.
//

import UIKit

class SessionTableViewCell: UITableViewCell {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var sessionMissedLabel: UILabel!
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var coustomView: UIView!
    @IBOutlet weak var infraValueLabel: UILabel!
    @IBOutlet weak var infraLabel: UILabel!
    @IBOutlet weak var attendanceStaff: UILabel!
    @IBOutlet weak var staffValueLabel: UILabel!
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var modeValueLabel: UILabel!
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var sessionTimeValueLabel: UILabel!
    @IBOutlet weak var sessionTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        moreInfoButton.layer.cornerRadius = 15
        coustomView.layer.cornerRadius = 15
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        coustomView.layer.masksToBounds = false
        coustomView.layer.shadowOffset = CGSize(width: -1, height: 1)
        coustomView.layer.shadowRadius = 3
        coustomView.layer.shadowOpacity = 0.1
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    
    func sessionConfigure(model:SessionModelData) {
         //   isSelectedFalse()
        moreInfoButton.layer.borderColor = UIColor.systemBlue.cgColor
        moreInfoButton.layer.borderWidth = 2
        moreInfoButton.setTitle("More Info", for: .normal)
        moreInfoButton.setImage(UIImage(systemName: "exclamationmark.circle"), for: .normal)
        moreInfoButton.semanticContentAttribute = .forceRightToLeft
        coustomView.backgroundColor = .white
            sessionTimeLabel.text = "Session Time"
            sessionTimeValueLabel.text = "\(DateFromWebtoApp(model.schedules?.first?.scheduleDate ?? "")),\(model.schedules?.first?.start?.hour ?? 0) : \(model.schedules?.first?.start?.minute ?? 00) \(model.schedules?.first?.start?.format ?? "") - \(model.schedules?.first?.end?.hour ?? 0): \(model.schedules?.first?.end?.minute ?? 00) \(model.schedules?.first?.end?.format ?? "")"
            modeLabel.text = "Mode"
            modeValueLabel.text = "\(model.schedules?.first?.mode ?? "")"
        if model.schedules?.first?.staffs?.count ?? 0 > 1 {
            staffLabel.text = "Multi Staff"
        } else {
            staffLabel.text = "Staff"
        }
        if model.schedules?.first?.status == "missed" {
            sessionMissedLabel.text = "Session Missed"
            sessionMissedLabel.textColor = .systemOrange
        } else {
            bottomView.isHidden = true
        }
           staffValueLabel.text = staffName(model:model)
            attendanceStaff.text = "Secondary Attendace Staff"
            infraLabel.text = "Infra"
            infraValueLabel.text = "\(model.schedules?.first?.infraName ?? "-")"
        }
    func staffName(model:SessionModelData) -> String {
            var staffNames = ""
        for (index,item) in (model.schedules?.first?.staffs ?? []).enumerated() {
                var staffName = ""
                if let first = item.staffName?.first, !first.isEmpty {
                    staffName += first
                }
                if let middle = item.staffName?.middle, !middle.isEmpty {
                    staffName += " " + middle
                }
                if let last = item.staffName?.last, !last.isEmpty {
                    staffName += " " + last
                }
                staffNames += staffName
                if index != (model.schedules?.first?.staffs ?? []).count - 1 {
                    staffNames += "\n"
                }
            }
            return staffNames.isEmpty ? "-" : staffNames
    }
    
    func DateFromWebtoApp(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = "MMM dd, yyyy"
        return  dateFormatter.string(from: date ?? Date())
    }
    
    }
