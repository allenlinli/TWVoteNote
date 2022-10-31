//
//  ContentView.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = AdminAreaCityAndCountyListViewModel()
    
    var body: some View {
        NavigationView {
            List($viewModel.adminAreas.reversed()) { adminArea in
                NavigationLink {
                    Text("123")
                } label: {
                    Text(adminArea.area.name.wrappedValue)
                }
            }
            .navigationTitle("選舉筆記本")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
