
import UIKit

class MyCourseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var buttonLabel: UILabel!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var mySessionTopButtons: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()

        customView.backgroundColor = .white.withAlphaComponent(0.5)
        customView.layer.cornerRadius = 14
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}
