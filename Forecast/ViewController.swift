import UIKit

class ViewController: UIViewController {
    
    let dailyForecast: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(red: 39/255, green:39/255, blue: 34/255, alpha: 1)
        label.textAlignment = .center
        label.toAutoLayout()
        label.text = "Ежедневный прогноз"
        label.backgroundColor = .white
        return label
    }()
    
    var attrs = [
        NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor : UIColor(red: 39/255, green:39/255, blue: 34/255, alpha: 1),
        NSAttributedString.Key.underlineStyle : 1] as [NSAttributedString.Key : Any]

    var attributedString = NSMutableAttributedString(string:"")
    
    lazy var moreSevenDays: UIButton = {
        let button = UIButton(type: .system)
        let buttonTitleStr = NSMutableAttributedString(string:"7 дней", attributes: attrs)
        attributedString.append(buttonTitleStr)
        button.setAttributedTitle(attributedString, for: .normal)
        button.addTarget(self, action: #selector(moreDays), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    @objc func moreDays() {
        let vc = DailySummaryViewController(realmModelDaily: modelDaily!, titleCity: nameCityCountry)
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
    
    private let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.toAutoLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(
            DailyCollectionCell.self,
            forCellWithReuseIdentifier: String(describing: DailyCollectionCell.self)
        )
        return collectionView
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
        obtainData()
        callHourlyCollecttionView.realmHourly = modelCurrentHourly
        resultOfRequest(apihourly: ApiType.geographicData(nameCity))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let realm = RealmDataProvider()
    
    let convert = ConverterModelData()
    
    var modelCurrentHourly: RealmModelCurrent?
    
    var modelDaily: RealmModelDaily?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let apiHourly = apiHourly else { return }
        guard let apiDaily = apiDaily else { return }
        resultOfRequest(apihourly: apiHourly)
        resultOfRequest(apihourly: apiDaily)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        view.addSubview(collectionView)
        view.addSubview(callHourlyCollecttionView)
        view.addSubview(moreSevenDays)
        view.addSubview(dailyForecast)
      
        [imageEllipse, imageSunset, imageSunrise, timeSunset, timeSunrise, tempNightAndDay, tempCurrent, weahtherDescription, imageRain, imageWind, imageClouds, clouds, rain, windSpeed, timeCurrent].forEach { view.addSubview($0) }
        setUp()
        view.backgroundColor = .white
        UserDefaults.standard.set("metric", forKey: Keys.stringKey.rawValue)
        
    }
    
    func obtainData() {
        guard let modelCurrentHourly = realm.obtainModelCurrent().first(where: { $0.id == id }) else { return }
        self.modelCurrentHourly = modelCurrentHourly
        
        guard let modelDaily = realm.obtainDailyModel().first(where: { $0.id == id }) else { return }
        self.modelDaily = modelDaily
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
            
            dailyForecast.topAnchor.constraint(equalTo: callHourlyCollecttionView.bottomAnchor,constant: 40),
            dailyForecast.leftAnchor.constraint(equalTo: collectionView.leftAnchor),
            
            moreSevenDays.topAnchor.constraint(equalTo: callHourlyCollecttionView.bottomAnchor, constant: 43),
            moreSevenDays.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            moreSevenDays.heightAnchor.constraint(equalToConstant: 20),
            moreSevenDays.widthAnchor.constraint(equalToConstant: 83),
            
            collectionView.topAnchor.constraint(equalTo: dailyForecast.bottomAnchor, constant: 10),
            collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    var apiDaily: ApiType?
    var apiHourly: ApiType?
    
    var latAndLon: String = "" {
        didSet {
            let parts = latAndLon.split(separator: " ")
            let longitude = Double(parts[0]) ?? Double()
            let latitude = Double(parts[1]) ?? Double()
            apiDaily = ApiType.getDaily(latitude, longitude)
            apiHourly = ApiType.getHourly(latitude, longitude)
            resultOfRequest(apihourly: apiDaily!)
            resultOfRequest(apihourly: apiHourly!)
        }
    }
    
    lazy var nameCityCountry: String = ""
    
    func resultOfRequest(apihourly: ApiType) {
    NetworkManager.obtainPost(apiType: apihourly) { [self] (result) in
                switch result {
                case .succesGeoData(data: let data):
                    latAndLon = data.first?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos ?? ""
                    guard let nameCountry = data.first?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.metaDataProperty?.geocoderMetaData?.text else { return }
                    
                    nameCityCountry = "\(nameCountry)"
                    print(data.first!)
                    
                case .succesHourly(data: let data):
                    self.modelCurrentHourly =  self.convert.convertHourlyModel(modelHourly: data.first!, id: id)
                    self.modelCurrentHourly?.nameCity = nameCity
                    self.realm.save(modelHourly: self.modelCurrentHourly!)
                    obtainData()
                    callHourlyCollecttionView.collectionView.reloadData()
        
                case .successDaily(data: let data):
                    self.modelDaily = self.convert.convertDailyModel(modelDaily: data.first!, id: id)
                    self.realm.save(modelDaily: self.modelDaily!)
                    obtainData()
                    collectionView.reloadData()
                    
                default:
                    break
                }
            }
    }
}

extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelDaily?.weatherDaily.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: DailyCollectionCell.self),
            for: indexPath) as! DailyCollectionCell
        
        cell.contentDaily = modelDaily?.weatherDaily[indexPath.row]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = (collectionView.bounds.width - 16 * 2)
        return CGSize(width: width, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: .zero, left: 16, bottom: 20, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DailySummaryViewController(realmModelDaily: modelDaily!, titleCity: nameCityCountry)
        navigationController?.pushViewController(vc, animated: true)
    }
}

protocol CreateHourlyViewController {
    func createHourlyViewController()
}

extension ViewController: CreateHourlyViewController{
    
    func createHourlyViewController() {
        let modelhourly = self.realm.obtainModelCurrent().first
        let vc = HourlyViewController(realmModelHourly: modelhourly!)
        vc.titleCity.text = nameCityCountry
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
