
import Foundation
import UIKit

class DailyCollectionCell: UICollectionViewCell {
    
    var contentDaily: ModelOneDay? {
        didSet {
            
            guard let tempDay = contentDaily?.tempDay, let tempMight = contentDaily?.tempNight else { return }
            dataOfdailyForecast.text = contentDaily?.dataForTableView
            temp.text = "\(tempMight)°-\((tempDay))°"
            weatherDescription.text = contentDaily?.weatherDescription
            
            guard let pop = contentDaily?.pop else { return }
            rain.text = "\(pop)%"
        }
    }
    
    private let imageRain: UIImageView = {
        let imageRain = UIImageView()
        imageRain.image = UIImage(named: "cloudsRain")
        imageRain.contentMode = .scaleAspectFit
        imageRain.toAutoLayout()
        return imageRain
    }()
    
    private let dataOfdailyForecast: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let rain: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let weatherDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()
    
    private let temp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private let imagerightContinue: UIImageView = {
        let imageRain = UIImageView()
        imageRain.image = UIImage(named: "rightContinue")
        imageRain.contentMode = .scaleAspectFit
        imageRain.toAutoLayout()
        return imageRain
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 5
        clipsToBounds = true
        backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func setUp() {
        
        [imageRain, imagerightContinue, rain, temp, weatherDescription, dataOfdailyForecast].forEach { contentView.addSubview($0) }
        
        let constraints = [
            dataOfdailyForecast.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            dataOfdailyForecast.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),

            imageRain.topAnchor.constraint(equalTo: dataOfdailyForecast.bottomAnchor, constant: 4.68),
            imageRain.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            imageRain.heightAnchor.constraint(equalToConstant: 17),
            imageRain.widthAnchor.constraint(equalToConstant: 15),

            rain.topAnchor.constraint(equalTo: dataOfdailyForecast.bottomAnchor, constant: 6),
            rain.leftAnchor.constraint(equalTo: imageRain.rightAnchor, constant: 5),

            weatherDescription.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 19),
            weatherDescription.leftAnchor.constraint(equalTo: rain.rightAnchor, constant: 13),
            weatherDescription.widthAnchor.constraint(equalToConstant: 206),

            temp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            
            imagerightContinue.centerYAnchor.constraint(equalTo: temp.centerYAnchor),
            imagerightContinue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            imagerightContinue.heightAnchor.constraint(equalToConstant: 9.49),
            imagerightContinue.widthAnchor.constraint(equalToConstant: 6),

            
          
            temp.rightAnchor.constraint(equalTo: imagerightContinue.leftAnchor, constant: -10),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
