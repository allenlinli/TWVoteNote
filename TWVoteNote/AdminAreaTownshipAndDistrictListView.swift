//
//  ContentView.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import SwiftUI

struct AdminAreaTownshipAndDistrictListView: View {
    
    @ObservedObject var viewModel = AdminAreaTownshipAndDistrictListViewModel()
    
    var body: some View {
        List($viewModel.adminAreas.reversed()) { adminArea in
            NavigationLink {
                Text("123")
            } label: {
                Text(adminArea.area.name.wrappedValue)
            }
        }
        .navigationTitle("鄉鎮區")
    }
}

struct AdminAreaTownshipAndDistrictListView_Previews: PreviewProvider {
    static var previews: some View {
        AdminAreaTownshipAndDistrictListView()
    }
}
