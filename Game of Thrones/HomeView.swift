//
//  ContentView.swift
//  Game of Thrones
//
//  Created by Conner Tate on 2/6/23.
//

import SwiftUI



struct HomeView: View {
    var networkController = NetworkController()
    
    @State private var houses: [House] = []
    @State private var loading = false
    
    func fetchHouses() {
        loading = true
        Task {
            do {
                let housesData = try await networkController.loadAllHouses()
                print("Loaded \(housesData.count) houses")
                await MainActor.run {
                    loading = false
                    houses = housesData
                }
            } catch {
                print("Error")
            }
        }
    }

    
    var body: some View {
        NavigationView {
            if(houses.isEmpty) {
                VStack {
                    Text("Game of Thrones Houses")
                        .font(.title2.weight(.semibold))
                        .padding()
                    
                    Image("gotLogo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                    
                    Button(action: fetchHouses) {
                        HStack {
                            Spacer()
                            
                            Text("Load Data")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                            
                            if(loading) {
                                ProgressView()
                                    .foregroundColor(.red)
                                    .tint(.white)
                            }
                            
                            Spacer()
                        }
                        .background(.black)
                        .cornerRadius(20)
                        .padding()
                    }
                    .buttonStyle(.plain)
                    
                }
                .background(.regularMaterial)
                .cornerRadius(20)
                .shadow(radius: 5)
                .padding(40)
                
                
            } else {
                List(houses, id: \.self) { house in
                    NavigationLink(destination: HouseDetailView(house: house)) {
                        VStack(alignment: .leading) {
                            Text(house.name)
                                .font(.headline)
                            Text(house.region)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .navigationBarTitle("Houses")
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
