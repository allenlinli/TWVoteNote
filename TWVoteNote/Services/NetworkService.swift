//
//  NetworkService.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import Foundation
import Combine
import Alamofire

struct NetworkError: Error {
  let initialError: AFError
  let backendError: BackendError?
}

struct BackendError: Codable, Error {
    var status: String
    var message: String
}

protocol NetworkServiceProtocol {
    func fetchAdminAreaCityAndCountyList() -> AnyPublisher<[AdministrativeArea], Never>
}


class NetworkService {
    static let shared: NetworkServiceProtocol = NetworkService()
    private init() { }
    
    let manager: Session = {
        let configuration: URLSessionConfiguration = {
            let configuration = URLSessionConfiguration.default
            configuration.headers = HTTPHeaders.default
            configuration.requestCachePolicy = .returnCacheDataElseLoad

            return configuration
        }()

        let manager = Session(configuration: configuration)

        return manager
    }()
}

extension NetworkService: NetworkServiceProtocol {
    func fetchAdminAreaCityAndCountyList() -> AnyPublisher<[AdministrativeArea], Never> {
        /*
         選舉黃頁 API (alpha)
         https://g0v.hackpad.tw/-API-alpha-y3IHgVIYYSY
         http://elections.olc.tw/api/areas/index/53c01bce-df94-4939-a456-5460acb5b862
         取得單層行政區資料， index/ 後面可以接個別行政區 id 來取得下一層資料
         index/ 後面沒有參數會顯示最上層（目前是縣市）
         */
        guard let url = Bundle.main.url(forResource: "AdministrativeAreaList", withExtension: "json") else {
            return Empty(completeImmediately: false).eraseToAnyPublisher()
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([AdministrativeArea].self, from: data)
            return Just(jsonData).eraseToAnyPublisher()
        } catch {
            return Empty(completeImmediately: false).eraseToAnyPublisher()
        }
    }
    
//    func fetchAdminAreaList() -> AnyPublisher<DataResponse<[AdministrativeArea], NetworkError>, Never> {

//        let url = URL(string: "https://elections.olc.tw/api/areas/index")!
//
//        return manager.request(url,
//                          method: .get)
//            .validate()
//            .publishDecodable(type: [AdministrativeArea].self)
//            .map { response in
//                response.mapError { error in
//                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
//                    print("fetchAdminAreaList NetworkError: \(error)")
//                    return NetworkError(initialError: error, backendError: backendError)
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//    }
}
