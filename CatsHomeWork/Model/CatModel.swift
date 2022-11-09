//
//  CatModel.swift
//  CatsHomeWork
//
//  Created by Kazakov Danil on 08.11.2022.
//

import Foundation


struct Cat: Codable {
    let breeds: [Breed]?
    let url: String?
}

struct Breed: Codable {
    let name: String
    let description: String
}
