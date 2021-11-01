import UIKit

class ViewController: UIViewController {

    var nameCityCountry: String = ""

    var viewModel: ViewModelDelegate?
    
    var clousureDailyViewController: ((_ modelDaily:RealmModelDaily,_ nameCity: String) -> Void)?
    
    var clousureHourlyViewController: ((RealmModelCurrent) -> Void)?
    
    
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        containerView.toAutoLayout()
        containerView.layer.cornerRadius = 5
        return containerView
    }()
    
    private let imageEllipse: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "Ellipse")
        imageEllipse.contentMode = .scaleToFill
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    private let imageSunset: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "sunset")?.withTintColor(UIColor(red: 246/255, green:221/255, blue: 1/255, alpha: 1))
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    private let imageSunrise: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "sunrise")?.withTintColor(UIColor(red: 246/255, green:221/255, blue: 1/255, alpha: 1))
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    let timeSunset: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "19:31"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let timeSunrise: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "05:41"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let tempNightAndDay: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "7/13"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let tempCurrent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "13"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let weahtherDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "Возможен небольшой дождь"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    private let imageClouds: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "clouds")
        imageEllipse.contentMode = .scaleAspectFit
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    private let imageRain: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "rain")?.withTintColor(UIColor.white)
        imageEllipse.contentMode = .scaleAspectFit
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    private let imageWind: UIImageView = {
        let imageEllipse = UIImageView()
        imageEllipse.image = UIImage(named: "wind")
        imageEllipse.contentMode = .scaleAspectFit
        imageEllipse.toAutoLayout()
        return imageEllipse
    }()
    
    let windSpeed: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "3 м/c"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let clouds: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "0"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let rain: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "75%"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    let timeCurrent: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor =  UIColor(red: 246/255, green:221/255, blue: 1/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "17:48, пт 16 апреля"
        label.backgroundColor = UIColor(red: 32/255, green: 78/255, blue: 199/255, alpha: 1)
        return label
    }()
    
    private lazy var callDailyCollectionView: CallDailyCollectionView = {
        let collection = CallDailyCollectionView()
        collection.toAutoLayout()
        collection.delegate = self
        return collection
    }()
    
    private lazy var callHourlyCollecttionView: CallHourlyCollecttionView = {
        let collection = CallHourlyCollecttionView()
        collection.toAutoLayout()
        collection.delegate = self
        return collection
    }()
    
    var nameCity: String
    
    var id: String
    

    init(id: String, nameCity: String) {
        self.id = id
        self.nameCity = nameCity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        viewModel?.resultOfRequestGeo(nameCity: self.nameCity, id: self.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)

        view.addSubview(callHourlyCollecttionView)

        view.addSubview(callDailyCollectionView)
        receiveDataFromViewModel()
        [imageEllipse, imageSunset, imageSunrise, timeSunset, timeSunrise, tempNightAndDay, tempCurrent, weahtherDescription, imageRain, imageWind, imageClouds, clouds, rain, windSpeed, timeCurrent].forEach { view.addSubview($0) }
        setUp()
        view.backgroundColor = .white
        UserDefaults.standard.set("metric", forKey: Keys.stringKey.rawValue)
        viewModel?.obtainsData(id: id)
        viewModel?.resultOfRequestGeo(nameCity: self.nameCity, id: self.id)
    }
    
    func receiveDataFromViewModel () {
        
        viewModel?.transferModelDaily = { [weak self] modelDaily in
            self?.callDailyCollectionView.modelDaily = modelDaily
            self?.callDailyCollectionView.collectionView.reloadData()
//            self?.modelDaily = modelDaily
        }

        viewModel?.transferModelCurrentHourly = { [weak self] modelHourly in
            self?.callHourlyCollecttionView.realmHourly = modelHourly
            self?.callHourlyCollecttionView.collectionView.reloadData()
//            self?.modelHourly = modelHourly
        }

        viewModel?.transferNameCountry = { [weak self] text in
            self?.nameCityCountry = text
        }
    }
    
    func setUp() {
        
        let constraints = [
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 69),
            containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            imageEllipse.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 17),
            imageEllipse.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 32),
            imageEllipse.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -32),
            imageEllipse.heightAnchor.constraint(equalToConstant: 123),
            
            imageSunset.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 145),
            imageSunset.centerXAnchor.constraint(equalTo: imageEllipse.trailingAnchor),
            imageSunset.heightAnchor.constraint(equalToConstant: 17),
            imageSunset.widthAnchor.constraint(equalToConstant: 17),
            
            imageSunrise.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 145),
            imageSunrise.centerXAnchor.constraint(equalTo: imageEllipse.leftAnchor),
            imageSunrise.heightAnchor.constraint(equalToConstant: 17),
            imageSunrise.widthAnchor.constraint(equalToConstant: 17),
            
            timeSunset.topAnchor.constraint(equalTo: imageSunset.bottomAnchor, constant: 5),
            timeSunset.centerXAnchor.constraint(equalTo: imageSunset.centerXAnchor),
            timeSunset.heightAnchor.constraint(equalToConstant: 17),
            
            timeSunrise.topAnchor.constraint(equalTo: imageSunrise.bottomAnchor, constant: 5),
            timeSunrise.centerXAnchor.constraint(equalTo: imageSunrise.centerXAnchor),
            timeSunrise.heightAnchor.constraint(equalToConstant: 17),
            
            tempNightAndDay.topAnchor.constraint(equalTo: imageEllipse.topAnchor, constant: 16),
            tempNightAndDay.centerXAnchor.constraint(equalTo: imageEllipse.centerXAnchor),
            tempNightAndDay.heightAnchor.constraint(equalToConstant: 20),
            
            tempCurrent.topAnchor.constraint(equalTo: tempNightAndDay.bottomAnchor, constant: 5),
            tempCurrent.centerXAnchor.constraint(equalTo: imageEllipse.centerXAnchor),
            tempCurrent.heightAnchor.constraint(equalToConstant: 40),
            
            weahtherDescription.topAnchor.constraint(equalTo: tempCurrent.bottomAnchor, constant: 5),
            weahtherDescription.centerXAnchor.constraint(equalTo: tempCurrent.centerXAnchor),
            weahtherDescription.heightAnchor.constraint(equalToConstant: 20),
            
            imageClouds.topAnchor.constraint(equalTo: weahtherDescription.bottomAnchor, constant: 15),
            imageClouds.leftAnchor.constraint(equalTo: imageEllipse.leftAnchor, constant: 46),
            imageClouds.heightAnchor.constraint(equalToConstant: 18),
            
            clouds.topAnchor.constraint(equalTo: weahtherDescription.bottomAnchor, constant: 15),
            clouds.leftAnchor.constraint(equalTo: imageClouds.rightAnchor, constant: 0),
            clouds.heightAnchor.constraint(equalToConstant: 18),
            
            imageWind.topAnchor.constraint(equalTo: imageClouds.topAnchor),
            imageWind.leftAnchor.constraint(equalTo: clouds.rightAnchor, constant: 19),
            imageWind.heightAnchor.constraint(equalToConstant: 18),
            
            windSpeed.topAnchor.constraint(equalTo: imageClouds.topAnchor),
            windSpeed.leftAnchor.constraint(equalTo: imageWind.rightAnchor, constant: 0),
            windSpeed.heightAnchor.constraint(equalToConstant: 18),
            
            imageRain.topAnchor.constraint(equalTo: imageClouds.topAnchor),
            imageRain.leftAnchor.constraint(equalTo: windSpeed.rightAnchor, constant: 19),
            imageRain.heightAnchor.constraint(equalToConstant: 18),
            
            rain.topAnchor.constraint(equalTo: imageClouds.topAnchor),
            rain.leftAnchor.constraint(equalTo: imageRain.rightAnchor, constant: 0),
            rain.trailingAnchor.constraint(equalTo: imageEllipse.trailingAnchor, constant: -46),
            rain.heightAnchor.constraint(equalToConstant: 18),
            
            timeCurrent.topAnchor.constraint(equalTo: imageClouds.bottomAnchor, constant: 15),
            timeCurrent.centerXAnchor.constraint(equalTo: imageEllipse.centerXAnchor),
            timeCurrent.heightAnchor.constraint(equalToConstant: 20),
            
            timeCurrent.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -21),
            
        
            callHourlyCollecttionView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 33),
            callHourlyCollecttionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            callHourlyCollecttionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            
            callDailyCollectionView.topAnchor.constraint(equalTo: callHourlyCollecttionView.bottomAnchor, constant: 40),
            callDailyCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            callDailyCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            callDailyCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
  
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}


//MARK: - delegateOfCallDailyCollectionView
protocol CreateDailySummaryViewController {
    func createDailySummaryViewController(_ modelDaily: RealmModelDaily)
}

extension ViewController: CreateDailySummaryViewController {
    
    func createDailySummaryViewController(_ modelDaily: RealmModelDaily) {
        clousureDailyViewController?(modelDaily, nameCityCountry)
    }
}

//MARK: - delegateOfCallHourlyCollecttionView
protocol CreateHourlyViewController {
    func createHourlyViewController(_ realmHourly: RealmModelCurrent)
}

extension ViewController: CreateHourlyViewController{
    
    func createHourlyViewController(_ realmHourly: RealmModelCurrent) {
        clousureHourlyViewController?(realmHourly)
    }
}
