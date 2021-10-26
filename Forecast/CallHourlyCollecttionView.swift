import Foundation
import UIKit

final class CallHourlyCollecttionView: UIView,  UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {

    var delegate: CreateHourlyViewController?
    
    var realmHourly: RealmModelCurrent?
    
    private let layout = UICollectionViewFlowLayout()
    
     lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(
            HourlyCollectionCell.self,
            forCellWithReuseIdentifier: String(describing: HourlyCollectionCell.self)
        )
        return collectionView
    }()
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : UIColor(red: 39/255, green:39/255, blue: 34/255, alpha: 1),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")
    
    lazy var moreDetails: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitleStr = NSMutableAttributedString(string:"Подробнее на 24 часа", attributes:attrs)
        attributedString.append(buttonTitleStr)
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.toAutoLayout()
        return button
    }()
    
    @objc func back() {
        delegate?.createHourlyViewController()
    }
    
    //    MARK:- UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return realmHourly?.hourlyWeather.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HourlyCollectionCell.self),
            for: indexPath) as! HourlyCollectionCell
        
        let content = realmHourly?.hourlyWeather[indexPath.row]
        
        cell.contentHourly = content
        
        let currentTime = Date()
        let time = Date(timeIntervalSince1970: Double(content!.dataDate))

        let contentNext = Date(timeIntervalSince1970: Double((realmHourly?.hourlyWeather[indexPath.row + 1].dataDate)!))

        if currentTime > time && currentTime < contentNext {
            cell.switcher = true
        } else {
            print(currentTime)
            cell.switcher = false
        }
        return cell
    }
//        MARK:- UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width - (8 * 6) - (16*2)) / 7
        return CGSize(width: width, height: 83)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 16, bottom: .zero, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.createHourlyViewController()
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout.scrollDirection = .horizontal
        addSubview(collectionView)
        addSubview(moreDetails)
       
        let constraints = [
            
            moreDetails.topAnchor.constraint(equalTo: topAnchor),
            moreDetails.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            moreDetails.heightAnchor.constraint(equalToConstant: 20),
            moreDetails.widthAnchor.constraint(equalToConstant: 174),
            
            collectionView.topAnchor.constraint(equalTo:  moreDetails.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 90),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

