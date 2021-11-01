
import Foundation
import UIKit

class DashedLineHorizonatalView: UIView {
    
    init() {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1).cgColor
        shapeLayer.lineWidth = 1
       
        shapeLayer.lineDashPattern = [4, 4]
        let path = CGMutablePath()
        path.addLines(between: [CGPoint(x: 0, y: 0), CGPoint(x: 180, y: 0)])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
}
