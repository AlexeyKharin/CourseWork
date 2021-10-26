import Foundation
enum ObtainPostResult {
    case successDaily(data: [ModelDaily])
    case succesHourly(data:[ModelHourly])
    case succesGeoData(data: [GeoData])
    case failure(error: Error)
}

struct NetworkManager {
    
    static func obtainPost(apiType: ApiType, completion: @escaping (ObtainPostResult) -> Void)  {
        
        let session = URLSession.shared
        let decoder = JSONDecoder()
        
        switch apiType {
        
        case .geographicData:
            session.dataTask(
                with: URLRequest(url: apiType.request)
            ) { (data, response, error) in
                
                var result: ObtainPostResult
                
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                        print(apiType.request)
                    }
                }
                
                if let parsData = data {
                    guard let posts = try? decoder.decode(GeoData.self, from: parsData) else {
                        result = .failure(error: error!)
                        return
                    }
                    result = .succesGeoData(data: [posts])
                } else {
                    result = .failure(error: error!)
                }
            }.resume()
            
        case .getDaily:
            session.dataTask(
                with: URLRequest(url: apiType.request)
            ) { (data, response, error) in
                
                var result: ObtainPostResult
                
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                
                if let parsData = data {
                    guard let posts = try? decoder.decode(ModelDaily.self, from: parsData) else {
                        result = .failure(error: error!)
                        return
                    }
                    result = .successDaily(data: [posts])
                } else {
                    result = .failure(error: error!)
                }
            }.resume()
            
        case .getHourly:
            session.dataTask(
                with: URLRequest(url: apiType.request)
            ) {  (data, response, error) in
                
                var result: ObtainPostResult
                
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                
                if let parsData = data {
                    guard let posts = try? decoder.decode(ModelHourly.self, from: parsData) else {
                        result = .failure(error: error!)
                        return
                    }
                    result = .succesHourly(data: [posts])
                } else {
                    result = .failure(error: error!)
                }
            }.resume()
        }
    }
}

