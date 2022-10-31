//
//  ContentView.swift
//  TWVoteNote
//
//  Created by Lin Li on 2022/10/31.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel = AdminAreaListViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach($viewModel.adminAreas, id: \.id) { adminArea in
                    HStack {
                        VStack(alignment: .leading) {
//                            Text(adminArea.name)
//                                .foregroundColor(.white)
//                                .font(.custom("Avenir", size: 16))
//                                .fontWeight(.heavy)
                            Text("allen")
                        }.padding(.horizontal)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
