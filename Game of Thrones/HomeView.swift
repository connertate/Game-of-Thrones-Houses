//
//  ContentView.swift
//  Game of Thrones
//
//  Created by Conner Tate on 2/6/23.
//

import SwiftUI

struct HomeView: View {
    @State private var houses: [House] = []
    @State private var loading = false
    
    var body: some View {
        NavigationView {
            if(houses.isEmpty) {
                VStack {
                    Spacer()
                    
                    HomeCardView(houses: $houses)
                    .padding(.horizontal)
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    APISourceLink()
                    .padding()
                }
            } else {
                List(houses, id: \.self) { house in
                    NavigationLink(destination: HouseDetailView(house: house)) {
                        HouseRowView(house: house)
                    }
                }
                .navigationBarTitle("Houses")
            }
        }
    }
}

struct HomeCardView: View {
    var networkController = NetworkController()
    @State var loading = false
    @Binding var houses: [House]
    
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
        VStack {
            Text("Game of Thrones Houses")
                .font(.title2.weight(.semibold))
                .padding()
            
            Image("gotLogo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal)
            
            Button(action: fetchHouses) {
                HStack {
                    Spacer()
                    
                    Text("Explore Houses")
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
        .shadow(radius: 10)
    }
}

struct HouseRowView: View {
    var house: House
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(house.name)
                .font(.headline)
            Text(house.region)
                .foregroundColor(.secondary)
        }
    }
}

struct APISourceLink: View {
    var body: some View {
        VStack() {
            Text("Data Source:")
            Link("An API of Ice And Fire", destination: URL(string:"https://www.anapioficeandfire.com")!)
        }
        .font(.footnote.weight(.semibold))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
