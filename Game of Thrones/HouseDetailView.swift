//
//  HouseDetailView.swift
//  Game of Thrones
//
//  Created by Conner Tate on 2/7/23.
//

import SwiftUI

struct HouseDetailView: View {
    var networkController = NetworkController()
    @State private var characters: [Character] = []
    @State private var showCharacterDetailView = false
    var selectedCharacter: Character? = nil
    let house: House
    
    func fetchMembers() {
        Task {
            do {
                let characterData = try await networkController.loadListOfCharacters(house.swornMembers)
                await MainActor.run {
                    characters = characterData
                }
            } catch {
                print("Error")
            }
        }
    }
    
    var body: some View {
        VStack {
            Text(house.name)
                .font(.title.weight(.semibold))
            Text(house.region)
                .foregroundColor(.secondary)
            
            List {
                Section(header: Text("Coat of Arms")) {
                    Text("\(house.coatOfArms)")
                }
                
                Section(header: Text("Members")) {
                    if(characters.isEmpty) {
                        Text("No known members")
                    } else {
                        ForEach(characters, id: \.self) { swornMember in
                            NavigationLink(destination: CharacterDetail(character: swornMember)) {
                                Text(swornMember.name)
                            }
                        }
                    }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            fetchMembers()
        }
    }
}

struct HouseDetailView_Previews: PreviewProvider {
    
    static let exampleHouse = House(
        url: "https://anapioficeandfire.com/api/houses/1",
        name: "House Algood",
        region: "The Westerlands",
        coatOfArms: "A golden wreath, on a blue field with a gold border",
        words: "",
        titles: [""],
        seats: [""],
        currentLord: "",
        heir: "",
        overlord: "https://www.anapioficeandfire.com/api/houses/229",
        founded: "",
        founder: "",
        diedOut: "",
        ancestralWeapons: [""],
        cadetBranches: [""],
        swornMembers: ["https://www.anapioficeandfire.com/api/characters/651","https://www.anapioficeandfire.com/api/characters/804","https://www.anapioficeandfire.com/api/characters/823","https://www.anapioficeandfire.com/api/characters/957","https://www.anapioficeandfire.com/api/characters/970"])
    
    static var previews: some View {
        HouseDetailView(house: exampleHouse)
    }
}
