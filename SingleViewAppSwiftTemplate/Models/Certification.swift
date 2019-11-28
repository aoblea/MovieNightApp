//
//  Certification.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/21/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct Certification: Decodable, Equatable {
  let certification: String
  let meaning: String
  let order: Int
  
  private enum CertificationCodingKeys: String, CodingKey {
    case certification
    case meaning
    case order
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CertificationCodingKeys.self)
    self.certification = try container.decode(String.self, forKey: .certification)
    self.meaning = try container.decode(String.self, forKey: .meaning)
    self.order = try container.decode(Int.self, forKey: .order)
  }
}

struct CertificationList: Decodable {
  let certifications: [String: [Certification]]
  
  private enum CertificationListCodingKeys: String, CodingKey {
    case certifications
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CertificationListCodingKeys.self)
    self.certifications = try container.decode([String: [Certification]].self, forKey: .certifications)
  }
}
