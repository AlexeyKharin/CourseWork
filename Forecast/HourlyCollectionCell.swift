
import Foundation
import UIKit

class HourlyCollectionCell: UICollectionViewCell {
    
    let units = UserDefaults.standard.object(forKey: Keys.stringKey.rawValue) as? String
    
    var contentHourly: RealmModelHourly? {
        didSet {
            dataOfHourlyyForecast.text = contentHourly?.time
            guard let image = UIImage(data: contentHourly?.imageCondition ?? Data()) else { return }
            imageCondition.image = image
            if units == "metric" {
                temp.text = "\(Int(contentHourly!.temp))°"
            } else if units == "imperial" {
                temp.text = "\(Int(contentHourly!.temp))°F"
            }
        }
    }
  
    var switcher: Bool? {
        didSet {
            if switcher! {
                backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
            } else {
                backgroundColor = .white
            }
        }
    }
    
    private let imageCondition: UIImageView = {
        let imageRain = UIImageView()
        imageRain.image = UIImage(named: "clouds")
        imageRain.contentMode = .scaleAspectFit
        imageRain.toAutoLayout()
        return imageRain
    }()
    
    private let temp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor =  UIColor(red: 52/255, green: 48/255, blue: 48/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let dataOfHourlyyForecast: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 156/255, green: 151/255, blue: 151/255, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        layer.cornerRadius = 22
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(red: 171/255, green: 188/255, blue: 234/255, alpha: 1).cgColor
        
        [temp, dataOfHourlyyForecast, imageCondition].forEach { contentView.addSubview($0) }
        
        let contraints = [
            
            dataOfHourlyyForecast.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            dataOfHourlyyForecast.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 2),
            dataOfHourlyyForecast.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            
            imageCondition.topAnchor.constraint(equalTo: dataOfHourlyyForecast.bottomAnchor, constant: 5),
            imageCondition.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageCondition.heightAnchor.constraint(equalToConstant: 20),
            imageCondition.widthAnchor.constraint(equalToConstant: 20),
            
            temp.topAnchor.constraint(equalTo: imageCondition.bottomAnchor, constant: 7),
            temp.centerXAnchor.constraint(equalTo: imageCondition.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(contraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
