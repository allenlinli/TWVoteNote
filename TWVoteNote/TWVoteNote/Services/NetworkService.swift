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
    func fetchAdministrativeAreaList() -> AnyPublisher<DataResponse<AdministrativeAreaList, NetworkError>, Never>
}


class NetworkService {
    static let shared: NetworkServiceProtocol = NetworkService()
    private init() { }
}

extension NetworkService: NetworkServiceProtocol {
    func fetchAdministrativeAreaList() -> AnyPublisher<DataResponse<AdministrativeAreaList, NetworkError>, Never> {
        /*
         選舉黃頁 API (alpha)
         https://g0v.hackpad.tw/-API-alpha-y3IHgVIYYSY
         http://elections.olc.tw/api/areas/index/53c01bce-df94-4939-a456-5460acb5b862
         取得單層行政區資料， index/ 後面可以接個別行政區 id 來取得下一層資料
         index/ 後面沒有參數會顯示最上層（目前是縣市）
         */
        let url = URL(string: "http://elections.olc.tw/api/areas/index")!
        
        return AF.request(url,
                          method: .get)
            .validate()
            .publishDecodable(type: AdministrativeAreaList.self)
            .map { response in
                response.mapError { error in
                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
                    return NetworkError(initialError: error, backendError: backendError)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
