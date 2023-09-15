
import Foundation
import UIKit

    class CircularProgressView: UIView {
        private var progressLayer = CAShapeLayer()
        private var remainingLayer = CAShapeLayer()
        override init(frame: CGRect) {
            super.init(frame: frame)
            setupCircularProgress()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupCircularProgress()
        }

        private func setupCircularProgress() {
            let circularPath = UIBezierPath(
                arcCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                radius: min(bounds.width, bounds.height) / 2 - 10,
                startAngle: -CGFloat.pi / 2,
                endAngle: 2 * CGFloat.pi - CGFloat.pi / 2,
                clockwise: true
            )

            progressLayer.path = circularPath.cgPath
            progressLayer.strokeColor = UIColor.systemBlue.cgColor // Set your desired progress color
            progressLayer.lineWidth = 5 // Set your desired line width
            progressLayer.fillColor = UIColor.clear.cgColor
            progressLayer.lineCap = .round
            progressLayer.strokeEnd = 0
            remainingLayer.path = circularPath.cgPath
            remainingLayer.strokeColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor // Remaining color
            remainingLayer.lineWidth = 5
            remainingLayer.fillColor = UIColor.clear.cgColor
            remainingLayer.lineCap = .round
            remainingLayer.strokeEnd = 1.0 // Full circle for remaining

            layer.addSublayer(remainingLayer)
            layer.addSublayer(progressLayer)
        }

        func setProgress(_ progress: Float) {
            progressLayer.strokeEnd = CGFloat(progress)
        }
    }
