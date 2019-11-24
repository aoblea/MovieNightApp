//
//  Genre.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct Genre: Decodable {
  let id: Int
  let name: String
  
  private enum GenreCodingKeys: String, CodingKey {
    case id
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: GenreCodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
  }
}

struct GenreList: Decodable {
  let genres: [Genre]
  
  private enum GenreList: String, CodingKey {
    case genres
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: GenreList.self)
    self.genres = try container.decode([Genre].self, forKey: .genres)
  }
}
