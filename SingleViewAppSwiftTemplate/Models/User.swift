//
//  User.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/24/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct User {
  var genres: [Genre] = []
  var certification: [Certification] = []
  var people: [Person] = []
  
  var isSelected = false
  var isFinish = false
}
