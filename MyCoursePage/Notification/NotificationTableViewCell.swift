
import UIKit

class NotificationTableViewCell: UITableViewCell {

    @IBOutlet weak var sessionLabelText: UILabel!
    @IBOutlet weak var sessionLabel: UIButton!
    @IBOutlet weak var feedBackLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
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
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
