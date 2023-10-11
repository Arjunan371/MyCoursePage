//
//  PopUpTableViewCell.swift
//  MyCoursePage
//
//  Created by Arjunan on 10/10/23.
//

import UIKit

class PopUpTableViewCell: UITableViewCell {

    @IBOutlet weak var createdTime: UILabel!
    @IBOutlet weak var attendanceImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var modeByLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
