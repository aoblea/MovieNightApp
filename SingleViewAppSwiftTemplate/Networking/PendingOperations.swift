//
//  PendingOperations.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/29/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

class PendingOperations {
  var downloadsInProgress = [IndexPath: Operation]()
  let downloadQueue = OperationQueue()
}
