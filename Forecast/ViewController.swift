import UIKit
class ViewController: UIViewController {
    
    let realm = RealmDataProvider()
    let convert = ConverterModelData()
    var model: RealmModelCurrent?
    var modelDaily: RealmModelDaily?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = .yellow
        UserDefaults.standard.set("metric", forKey: Keys.stringKey.rawValue)
        
        _ = ApiType.geographicData("Бостон")
        let apihourly = ApiType.getDaily(52.6329, 27.5618)
       
        print(apihourly.request.absoluteString)
        NetworkManager.obtainPost(apiType: apihourly) { (result) in
            switch result {
            case .succesGeoData(data: let data):
                let string = data.first?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos
                let parts = string?.split(separator: " ")
                print(parts![0])
            case .succesHourly(data: let data):
                print(data.first?.timezone)
                self.model =  self.convert.convertHourlyModel(modelHourly: data.first!)
                self.realm.save(modelHourly: self.model!)
            case .successDaily(data: let data):
                print(data.first?.timezone)
                self.modelDaily = self.convert.convertDailyModel(modelDaily: data.first!)
                self.realm.save(modelDaily: self.modelDaily!)
            default:
                break
            }
        }
        print(realm.obtainDailyModel().first)
        print(realm.obtainModelCurrent().count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
}

