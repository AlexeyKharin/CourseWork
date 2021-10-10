import Foundation
import UIKit

class ConverterModelData {
    
    func convertHourlyModel(modelHourly: ModelHourly) ->  RealmModelCurrent {
        let model = RealmModelCurrent()
        guard let currentTime = modelHourly.current?.dt, let sunriseTime = modelHourly.current?.sunrise, let sunsetTime = modelHourly.current?.sunset else { return model}
        guard let safetyModelTimeZone = modelHourly.timezone else { return model }
        let pop = modelHourly.current?.pop
        guard let clouds = modelHourly.current?.clouds else { return model}
        guard let weatherDescription =  modelHourly.current?.weather?.first?.weatherDescription else { return model}
        guard let windSpeed = modelHourly.current?.windSpeed else { return model}
        guard let hourly = modelHourly.hourly else { return model}
        
        let dateFormatter = DateFormatter()
        let dataTimeCurrent = Date(timeIntervalSince1970: Double(currentTime))
        let dataTimeSunset = Date(timeIntervalSince1970: Double(sunsetTime))
        let dataTimeSunrise = Date(timeIntervalSince1970: Double(sunriseTime))
        
        dateFormatter.dateFormat = "HH:mm, E d MMM"
        dateFormatter.timeZone = TimeZone(identifier: safetyModelTimeZone)
        
        let stringTimeCurrent = dateFormatter.string(from: dataTimeCurrent)
        let stringTimeSunset  = dateFormatter.string(from: dataTimeSunset)
        let stringTimeSunrise = dateFormatter.string(from: dataTimeSunrise)
        
        model.sunriseTime = stringTimeSunrise
        model.sunsetTime = stringTimeSunset
        model.currentTime = stringTimeCurrent
        model.timezone = safetyModelTimeZone
        model.pop = pop ?? Double()
        model.clouds = clouds
        model.weatherDescription = weatherDescription
        model.windSpeed = windSpeed
        
        for i in hourly {
            let hourModel = RealmModelHourly()
            guard let hourTime = i.dt else { return model}
            guard let clouds = i.clouds else { return model}
            guard let feelsLike =  i.feelsLike else { return model}
            guard let temp = i.temp else { return model}
            guard let pop = i.pop else { return model}
            guard let weatherDescription = i.weather?.first?.weatherDescription else { return model}
            guard let weatherGroup = i.weather?.first?.main else { return model}
            guard let windSpeed = i.windSpeed else { return model}
            
            let dataTimeCurrent = Date(timeIntervalSince1970: Double(hourTime))
            
            dateFormatter.dateFormat = "HH:mm"
            let stringTimeHour = dateFormatter.string(from: dataTimeCurrent)
            dateFormatter.dateFormat = "MMM d/MM"
            let stringData  = dateFormatter.string(from: dataTimeCurrent)
            
            hourModel.clouds = clouds
            hourModel.data = stringData
            hourModel.time = stringTimeHour
            hourModel.tempFeelsLike = feelsLike
            hourModel.temp = temp
            hourModel.pop = pop
            hourModel.weatherDescription = weatherDescription
            hourModel.weatherGroup = weatherGroup
            hourModel.windSpeed = windSpeed
            model.hourlyWeather.append(hourModel)
        }
        return model
    }
    
    func convertDailyModel(modelDaily: ModelDaily) -> RealmModelDaily {
        
        let model = RealmModelDaily()
        
        let dateFormatter = DateFormatter()
        guard let timeZone = modelDaily.timezone else { return model }
        dateFormatter.timeZone = TimeZone(identifier: timeZone)
        
        guard let daily = modelDaily.daily else { return model }
        for day in daily {
            let modelOneDay = ModelOneDay()

            modelOneDay.clouds = day.clouds ?? Int()
            modelOneDay.feelsLikeDay = day.feelsLike?.day ?? Double()
            modelOneDay.feelsLikeNight = day.feelsLike?.night ?? Double()
            modelOneDay.tempDay = day.temp?.day ?? Double()
            modelOneDay.tempNight = day.temp?.night ?? Double()
            modelOneDay.pop = day.pop ?? Double()
            modelOneDay.uvi = day.uvi ?? Double()
            modelOneDay.weatherDescription = day.weather?.first?.weatherDescription ?? String()
            modelOneDay.main = day.weather?.first?.main ?? String()
            modelOneDay.windSpeed = day.windSpeed ?? Double()
            
            guard let sunrise = day.sunrise, let sunset = day.sunset, let moonset = day.moonset, let moonrise = day.moonrise, let data = day.dt else { return model }
            
            let dataTime = Date(timeIntervalSince1970: Double(data))
            let dataTimemoonrise = Date(timeIntervalSince1970: Double(moonrise))
            let dataTimemoonset = Date(timeIntervalSince1970: Double(moonset))
            let dataTimesunset = Date(timeIntervalSince1970: Double(sunset))
            let dataTimesunrise = Date(timeIntervalSince1970: Double(sunrise))
            
            dateFormatter.dateFormat = "MM/dd"
            let stringDataForTableView = dateFormatter.string(from: dataTime)
            modelOneDay.dataForTableView = stringDataForTableView
            
            dateFormatter.dateFormat = "MM/dd MMM"
            let stringDataForCollection = dateFormatter.string(from: dataTime)
            modelOneDay.dataForCollection = stringDataForCollection
           
            dateFormatter.dateFormat = "HH:mm"
            let stringTimeMoonrise = dateFormatter.string(from: dataTimemoonrise)
            let stringTimeMoonset = dateFormatter.string(from: dataTimemoonset)
            let stringTimeSunset = dateFormatter.string(from: dataTimesunset)
            let stringTimeSunrise = dateFormatter.string(from: dataTimesunrise)
            
            modelOneDay.moonrise = stringTimeMoonrise
            modelOneDay.moonset = stringTimeMoonset
            modelOneDay.sunset = stringTimeSunset
            modelOneDay.sunrise = stringTimeSunrise
            
            model.weatherDaily.append(modelOneDay)
        }
        return model
    }
}
