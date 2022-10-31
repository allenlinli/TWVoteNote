//
//  AdminAreaListViewModel.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import Foundation
import Combine
class AdminAreaListViewModel: ObservableObject {
    
    @Published var adminAreas =  [AdminArea]()
    @Published var adminAreaListLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkServiceProtocol
    
    init( dataManager: NetworkServiceProtocol = NetworkService.shared) {
        self.dataManager = dataManager
        getAdminAreaList()
    }
    
    func getAdminAreaList() {
        dataManager.fetchAdminAreaList()
            .sink { [weak self] (dataResponse) in
                guard let self = self else { return }
                guard dataResponse.error == nil else {
                    self.createAlert(with: dataResponse.error!)
                    return
                }
                self.adminAreas = dataResponse.value!
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        adminAreaListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
