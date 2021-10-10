
import Foundation
import RealmSwift

@objcMembers
class RealmModelDaily: Object {
    
    dynamic var id: String = "0"
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    dynamic var weatherDaily = List<ModelOneDay>()
    
   
}
@objcMembers
class ModelOneDay: Object {
    
    dynamic var dataForCollection: String = String()
    dynamic var dataForTableView: String = String()
    dynamic var sunrise: String = String()
    dynamic var sunset: String = String()
    dynamic var moonrise: String = String()
    dynamic var moonset: String = String()
    dynamic var feelsLikeNight: Double = Double()
    dynamic var feelsLikeDay: Double = Double()
    dynamic var tempDay: Double = Double()
    dynamic var tempNight: Double = Double()
    dynamic var uvi: Double = Double()
    dynamic var clouds: Int = Int()
    dynamic var windSpeed: Double = Double()
    dynamic var pop: Double = Double()
    dynamic var weatherDescription: String = String()
    dynamic var main: String = String()
}
