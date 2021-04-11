







import UIKit
class ProgressCellCollection: UICollectionViewCell {
    
    var progressInformation: Float? {
        didSet {
            cellProgress.progressInformation = progressInformation
        }
    }
    
    private let cellProgress = CellProgress.nibInstance()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        cellProgress.toAutoLayout()
        contentView.addSubview(cellProgress)
        let constraints = [
            cellProgress.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellProgress.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellProgress.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellProgress.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

