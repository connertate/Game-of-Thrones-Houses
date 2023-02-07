//
//  CharacterDetailView.swift
//  Game of Thrones
//
//  Created by Conner Tate on 2/7/23.
//

import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    func formatString(_ str: String) -> String {
        str == "" ? "Unknown" : str
    }
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Text(character.name)
                    .font(.title2.weight(.semibold))
                Spacer()
            }
            
            CharFactRow(key: "Aliases:", value: formatString("\(character.aliases.joined(separator: ", "))"))
            CharFactRow(key: "Titles:", value: formatString("\(character.titles.joined(separator: ", "))"))
            CharFactRow(key: "Born:", value: formatString(character.born))
            CharFactRow(key: "Died", value: formatString(character.died))
            CharFactRow(key: "Culture", value: formatString(character.culture))
        }
    }
}

struct CharFactRow: View {
    let key: String
    let value: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(key)
                .fontWeight(.semibold)
            
            Spacer()
            
            Text(value)
        }
        .font(.subheadline)
    }
}

//struct CharacterDetailView_Previews: PreviewProvider {
//    static let previewCharacter = Character(id: <#T##Int#>, name: <#T##String#>, culture: <#T##String#>, born: <#T##String#>, died: <#T##String#>, titles: <#T##[String]#>, aliases: <#T##[String]#>)
//
//    static var previews: some View {
//        CharacterDetailView()
//    }
//}
