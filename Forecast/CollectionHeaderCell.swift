

import Foundation
import UIKit

class CollectionHeaderCell: UICollectionViewCell {
    
    var contentDaily: ModelOneDay? {
        didSet {
            data.text = contentDaily?.dataForCollection
        }
    }
    
    var switcher: Bool? {
        didSet {
            if switcher! {
                backgroundColor =  UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
                data.textColor =  UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

            } else {
                backgroundColor = .white
                data.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
            }
        }
    }
    
     let data: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
//        clipsToBounds = true
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUp() {
        contentView.addSubview(data)
        let constraints = [
            data.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            data.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            data.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            data.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
