//
//  NetworkController.swift
//  Game of Thrones
//
//  Created by Conner Tate on 2/7/23.
//

import Foundation

class NetworkController {
    var session = URLSession.shared
    
    func loadAllHouses() async throws -> [House] {
        var res = [House]()
        var page = 1
        var moreData = true
        let decoder = JSONDecoder()
        
        while(moreData) {
            let pagedHouseURL = URL(string: "https://www.anapioficeandfire.com/api/houses?page=" + String(page) + "&pageSize=50")!
            
            let (data, _) = try await session.data(from: pagedHouseURL)
            let newHouses =  try decoder.decode([House].self, from: data)
            
            if(newHouses.count == 0) {
                moreData = false
            } else {
                page += 1
                res += newHouses
            }
        }
        
        return res
    }
    
    func loadListOfCharacters(_ chars: [String]) async throws -> [Character] {
        var res = [Character]()
        let decoder = JSONDecoder()
        
        for char in chars {
            let charURL = URL(string: char)!
            
            let (data, _) = try await session.data(from: charURL)
            let newChar =  try decoder.decode(Character.self, from: data)
            
            res.append(newChar)
        }
        
        return res
    }
    
    
}
