//
//  Person.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct Person: Decodable {
  let id: Int
  let name: String
  
  private enum PersonCodingKeys: String, CodingKey {
    case id
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PersonCodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
  }
}

struct PersonResults: Decodable {
  let page: Int
  let totalResults: Int
  let totalPages: Int
  let results: [Person]
  
  private enum PersonResultsCodingKeys: String, CodingKey {
    case page
    case totalResults
    case totalPages
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: PersonResultsCodingKeys.self)
    self.page = try container.decode(Int.self, forKey: .page)
    self.totalResults = try container.decode(Int.self, forKey: .totalResults)
    self.totalPages = try container.decode(Int.self, forKey: .totalPages)
    self.results = try container.decode([Person].self, forKey: .results)
  }
}
