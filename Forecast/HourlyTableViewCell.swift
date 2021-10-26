
import Foundation
import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    var contentHour: RealmModelHourly? {
        didSet {
            guard let pop = contentHour?.pop else { return }
            guard let windSpeed = contentHour?.windSpeed else { return }
            guard let tempFeelsLike =  contentHour?.tempFeelsLike else { return }
            guard let clouds = contentHour?.clouds else { return }
            data.text = contentHour?.data
            hour.text = contentHour?.time
            temp.text = "\(Int(contentHour!.temp))°"
            precipitationValue.text = "\(Int(pop*100))%"
            windSpeedValue.text = "\(Int(windSpeed)) m/s"
            cloudyValue.text = "\(clouds)%"
            feelLikesValue.text = "\(Int(tempFeelsLike))°"
        }
    }
    
    let data: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let hour: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let temp: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    private let imageMoon: UIImageView = {
        let imageMoon = UIImageView()
        imageMoon.image = UIImage(named: "moon")
        imageMoon.contentMode = .scaleAspectFit
        imageMoon.toAutoLayout()
        return imageMoon
    }()

    private let imageWind: UIImageView = {
        let imageWind = UIImageView()
        imageWind.image = UIImage(named: "wind")
        imageWind.contentMode = .scaleAspectFit
        imageWind.toAutoLayout()
        return imageWind
    }()
    
    private let imageDrop: UIImageView = {
        let imageDrop = UIImageView()
        imageDrop.image = UIImage(named: "drop")
        imageDrop.contentMode = .scaleAspectFit
        imageDrop.toAutoLayout()
        return imageDrop
    }()
    
    private let imageClouds: UIImageView = {
        let imageClouds = UIImageView()
        imageClouds.image = UIImage(named: "clouds")
        imageClouds.contentMode = .scaleAspectFit
        imageClouds.toAutoLayout()
        return imageClouds
    }()
    
    let feelLikes: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.toAutoLayout()
        label.text = "По ощущению"
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let windSpeed: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.text = "Ветер"
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let precipitation: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.text = "Атмосферные осадки"
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let cloudy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 39/255, green: 39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .left
        label.text = "Облачность"
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let feelLikesValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let cloudyValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let windSpeedValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    let precipitationValue: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(red: 154/255, green: 150/255, blue: 150/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.backgroundColor = UIColor(red: 233/255, green: 238/255, blue: 250/255, alpha: 1)
        [cloudy, cloudyValue, precipitation, precipitationValue, feelLikes, feelLikesValue, windSpeed, windSpeedValue, imageDrop, imageWind, imageClouds, imageMoon, temp, hour, data ].forEach { contentView.addSubview($0) }
        
        let constraints = [
            data.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            data.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            hour.topAnchor.constraint(equalTo: data.bottomAnchor, constant: 8),
            hour.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            temp.topAnchor.constraint(equalTo: hour.bottomAnchor, constant: 10),
            temp.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            imageMoon.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 48),
            imageMoon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 74),
            imageMoon.heightAnchor.constraint(equalToConstant: 9.58),
            imageMoon.widthAnchor.constraint(equalToConstant: 11.11),
            
            imageWind.topAnchor.constraint(equalTo: imageMoon.bottomAnchor, constant: 16),
            imageWind.centerXAnchor.constraint(equalTo: imageMoon.centerXAnchor),
            imageWind.heightAnchor.constraint(equalToConstant: 10.05),
            imageWind.widthAnchor.constraint(equalToConstant: 15),
            
            imageDrop.topAnchor.constraint(equalTo: imageWind.bottomAnchor, constant: 12),
            imageDrop.centerXAnchor.constraint(equalTo: imageMoon.centerXAnchor),
            imageDrop.heightAnchor.constraint(equalToConstant: 13),
            imageDrop.widthAnchor.constraint(equalToConstant: 11),
            
            imageClouds.topAnchor.constraint(equalTo: imageDrop.bottomAnchor, constant: 11),
            imageClouds.centerXAnchor.constraint(equalTo: imageMoon.centerXAnchor),
            imageClouds.heightAnchor.constraint(equalToConstant: 10),
            imageClouds.widthAnchor.constraint(equalToConstant: 14),
            
            feelLikes.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 45),
            feelLikes.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 92),
            
            windSpeed.topAnchor.constraint(equalTo: feelLikes.bottomAnchor, constant: 8),
            windSpeed.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 92),
            
            precipitation.topAnchor.constraint(equalTo: windSpeed.bottomAnchor, constant: 8),
            precipitation.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 92),
            
            cloudy.topAnchor.constraint(equalTo: precipitation.bottomAnchor, constant: 8),
            cloudy.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 92),
            
            feelLikesValue.centerYAnchor.constraint(equalTo: feelLikes.centerYAnchor),
            feelLikesValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            windSpeedValue.centerYAnchor.constraint(equalTo: windSpeed.centerYAnchor),
            windSpeedValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            precipitationValue.centerYAnchor.constraint(equalTo: precipitation.centerYAnchor),
            precipitationValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            cloudyValue.centerYAnchor.constraint(equalTo: cloudy.centerYAnchor),
            cloudyValue.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
