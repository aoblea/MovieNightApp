//
//  Movie.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

class Movie: Decodable {
  let id: Int
  let originalTitle: String
  let genre: [Genre]
  let title: String
  let overview: String
  let releaseDate: String
  
  private enum MovieCodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case genre = "genre_ids"
    case title
    case overview
    case releaseDate = "release_date"
  }
  
  init(id: Int, originalTitle: String, genre: [Genre], title: String, overview: String, releaseDate: String) {
    self.id = id
    self.originalTitle = originalTitle
    self.genre = genre
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MovieCodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
    self.genre = try container.decode([Genre].self, forKey: .genre)
    self.title = try container.decode(String.self, forKey: .title)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
  }
}
