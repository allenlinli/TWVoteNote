//
//  AdminAreaTownshipAndDistrictListViewModel.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import Foundation
import Combine
class AdminAreaTownshipAndDistrictListViewModel: ObservableObject {
    
    @Published var adminAreas =  [AdminArea]()
    @Published var adminAreaListLoadingError: String = ""
    @Published var showAlert: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    var dataManager: NetworkServiceProtocol
    
    init(dataManager: NetworkServiceProtocol = NetworkService.shared) {
        self.dataManager = dataManager
        getAdminAreaList()
    }
    
    func getAdminAreaList() {
        dataManager.fetchAdminAreaCityAndCountyList()
            .sink { [weak self] (administrativeAreas) in
                guard let self = self else { return }
                self.adminAreas = administrativeAreas
            }.store(in: &cancellableSet)
    }
    
    func createAlert( with error: NetworkError ) {
        adminAreaListLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
    }
}
