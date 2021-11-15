
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
        let constraints = [
            
            collection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            collection.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            collection.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
