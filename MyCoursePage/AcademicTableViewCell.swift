//
//  AcademicTableViewCell.swift
//  MyCoursePage
//
//  Created by Arjunan on 11/09/23.
//

import UIKit

class AcademicTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var academicLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        customView.layer.cornerRadius = 10
       contentView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
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

        // Configure the view for the selected state
    }
    
}
