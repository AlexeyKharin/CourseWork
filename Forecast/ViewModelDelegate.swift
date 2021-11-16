
import Foundation
import UIKit

protocol ViewModelDelegate {
    
    var transferModelDaily: ((RealmModelDaily) -> Void)? { get set }
    
    var transferModelCurrentHourly: ((RealmModelCurrent) -> Void)? { get set }
    
    func obtainsData(id: String)
    
    func resultOfRequestGeo(nameCity: String, id: String)
    
    var transferNameCountry: ((String) -> Void)? { get set }
}

class ViewModel: ViewModelDelegate {
    
    var realm: RealmDataProvider?
    
    var convert: ConverterModelData?
    
    var transferModelDaily: ((RealmModelDaily) -> Void)?
    
    var transferModelCurrentHourly: ((RealmModelCurrent) -> Void)?
    
    var transferNameCountry: ((String) -> Void)?
    
    private var modelCurrentHourly = RealmModelCurrent()  {
        didSet {
            transferModelCurrentHourly?(modelCurrentHourly)
        }
    }
    
    private var modelDaily: RealmModelDaily = RealmModelDaily() {
        didSet {
            transferModelDaily?(modelDaily)
        }
    }
    
    func resultOfRequestGeo(nameCity: String, id: String) {
        let apiGeo = ApiType.geographicData(nameCity)
        NetworkManager.obtainPost(apiType: apiGeo) { [self] (result) in
            switch result {
            case .succesGeoData(data: let data):
                let latAndLon = data.first?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.point?.pos ?? ""
                let parts = latAndLon.split(separator: " ")
                let longitude = Double(parts[0])
                let latitude = Double(parts[1])
                
                resultOfRequesDaily(id: id, latitude: latitude!, longitude: longitude!)
                resultOfRequesHourly(nameCity: nameCity, id: id, latitude: latitude!, longitude: longitude!)
                guard let nameCountry = data.first?.response?.geoObjectCollection?.featureMember?.first?.geoObject?.metaDataProperty?.geocoderMetaData?.text else { return }
                transferNameCountry?(nameCountry)
            case .failure(error: let error):
                obtainsData(id: id)
                print(error)
            default:
                break
            }
        }
    }
    
    func obtainsData(id: String) {
        guard let modelCurrentHourly = realm?.obtainModelCurrent().first(where: { $0.id == id }) else { return }
        self.modelCurrentHourly = modelCurrentHourly
        
        guard let modelDaily = realm?.obtainDailyModel().first(where: { $0.id == id }) else { return }
        self.modelDaily = modelDaily
    }
    
    private func resultOfRequesDaily(id: String, latitude: Double, longitude: Double) {
        let apiDaily = ApiType.getDaily(latitude, longitude)
        NetworkManager.obtainPost(apiType: apiDaily) { [self] (result) in
            switch result {
            case .successDaily(data: let data):
                let model = convert?.convertDailyModel(modelDaily: data.first!, id: id)
                realm?.save(modelDaily: model!)
                obtainsData(id: id)
            case .failure(error: let error):
                obtainsData(id: id)
                print(error)
            default:
                break
            }
        }
    }
    
    private func resultOfRequesHourly(nameCity: String, id: String, latitude: Double, longitude: Double) {
        let apiHourly = ApiType.getHourly(latitude, longitude)
        NetworkManager.obtainPost(apiType: apiHourly) { [self] (result) in
            switch result {
            case .succesHourly(data: let data):
                let model = convert?.convertHourlyModel(modelHourly: data.first!, id: id)
                model?.nameCity = nameCity
                realm?.save(modelHourly: model!)
                obtainsData(id: id)
            case .failure(error: let error):
                obtainsData(id: id)
                print(error)
            default:
                break
            }
        }
    }
}

