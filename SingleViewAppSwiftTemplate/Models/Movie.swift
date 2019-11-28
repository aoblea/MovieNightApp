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
  let title: String
  let overview: String
  let releaseDate: String
  
  private enum MovieCodingKeys: String, CodingKey {
    case id
    case originalTitle
    case genreids 
    case title
    case overview
    case releaseDate
  }
  
  init(id: Int, originalTitle: String, genreIDs: [Genre?], title: String, overview: String, releaseDate: String) {
    self.id = id
    self.originalTitle = originalTitle
    self.title = title
    self.overview = overview
    self.releaseDate = releaseDate
  }
  
  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MovieCodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
    self.title = try container.decode(String.self, forKey: .title)
    self.overview = try container.decode(String.self, forKey: .overview)
    self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
  }
}

struct MovieResults: Decodable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: [Movie]
  
  private enum MovieResultsCodingKeys: String, CodingKey {
    case page
    case totalResults
    case totalPages
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: MovieResultsCodingKeys.self)
    self.page = try container.decode(Int.self, forKey: .page)
    self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    self.results = try container.decode([Movie].self, forKey: .results)
  }
}
