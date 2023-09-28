
import UIKit

class MyCourseTableViewCell: UITableViewCell {
    
    let viewModel = MyCourseVieModel()
    @IBOutlet weak var downArrow: UIButton!
    @IBOutlet weak var circularViewLabel: UILabel!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var customView: UIView!
    @IBOutlet weak var circularView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var warningButton: UIButton!
    @IBOutlet weak var inProgressLabel: UILabel!
    @IBOutlet weak var sessionsCompletedLabel: UILabel!
    @IBOutlet weak var sessionAttendBelowLabel: UILabel!
    @IBOutlet weak var sessionAttendLabel: UILabel!
    @IBOutlet weak var attendanceDetailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var topicLabel: UILabel!
  var ViewControllers = ViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        forCardStyleShadow()
        warningButton.layer.cornerRadius = 15
        warningButton.layer.borderColor = CGColor(red: 1, green: 0.757, blue: 0.133, alpha: 1)
        warningButton.layer.borderWidth = 1
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        progressView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06)
        contentView.backgroundColor = UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        warningButton.backgroundColor = UIColor(red: 1, green: 0.946, blue: 0.754, alpha: 1)
        warningButton.titleLabel?.font = .systemFont(ofSize: 12)
        customView.layer.masksToBounds = false
        customView.layer.shadowOffset = CGSize(width: -1, height: 1)
        customView.layer.shadowRadius = 3
        customView.layer.shadowOpacity = 0.1
    }
    
    func constraintForProgressView() {
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: circularView.topAnchor),
            progressView.bottomAnchor.constraint(equalTo: circularView.bottomAnchor),
            progressView.trailingAnchor.constraint(equalTo: circularView.trailingAnchor),
            progressView.leadingAnchor.constraint(equalTo: circularView.leadingAnchor),])
    }
    func forCardStyleShadow(){
        view1.layer.cornerRadius = 10
        customView.layer.cornerRadius = 10
    }
    func forCircularView(setprogres: Float = 0) {
        circularView.backgroundColor = UIColor.clear
        let circularViews = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        circularView.addSubview(circularViews)
        // Update the progress (0.0 to 1.0)
        circularViews.setProgress(setprogres)
    }
    
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
