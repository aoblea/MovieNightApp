//
//  MovieNightClient.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

class MovieNightClient: APIClient {
  let session: URLSession
  var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  private let apiKey: String = "34d74b3c4d3a6d099c7422cb6b1a5c77"
  
  init(configuration: URLSessionConfiguration) {
    self.session = URLSession(configuration: configuration)
  }
  
  convenience init() {
    self.init(configuration: .default)
  }
  
  func genreList(completion: @escaping (Result<GenreList, APIError>) -> Void) {
    let endpoint = MovieNight.genre(api: apiKey)
    let request = endpoint.request
    print(request)
    fetch(with: request, completion: completion)
  }
  
  func certificationList(completion: @escaping (Result<CertificationList, APIError>) -> Void) {
    let endpoint = MovieNight.certification(api: apiKey)
    let request = endpoint.request
    print(request)
    fetch(with: request, completion: completion)
  }
  
  func people(completion: @escaping (Result<PersonResults, APIError>) -> Void) {
    let endpoint = MovieNight.people(api: apiKey, page: 1)
    let request = endpoint.request
    print(request)
    fetch(with: request, completion: completion)
  }
  
  func discover() {
    
  }
  
}
