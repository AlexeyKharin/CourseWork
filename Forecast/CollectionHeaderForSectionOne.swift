
import Foundation
import UIKit
class CollectionHeaderForSectionOne: UITableViewHeaderFooterView {
    
    var contentDaily: RealmModelDaily? {
        didSet {
            collection.contentDaily = contentDaily
        }
    }
    var dataTransfer: ((ModelOneDay) -> Void)?
    
    private lazy var collection: CallCollectionView = {
        let collection = CallCollectionView()
        collection.toAutoLayout()
        return collection
    }()
    
     let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
         setUp()
        
        collection.dataTransfer = { [weak self] model in
            self?.dataTransfer?(model)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        contentView.addSubview(collection)
        contentView.addSubview(title)
        let constraints = [
            
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            title.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            collection.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 40),
            collection.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
