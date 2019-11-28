//
//  CertificationListDataSource.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/27/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class CertificationListDataSource: NSObject, UITableViewDataSource {
  
  private var data = [Certification]()
  
  override init() {
    super.init()
  }
  
  // MARK: - Table view data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CertificationCell", for: indexPath)
    cell.textLabel?.text = object(at: indexPath).certification
    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Certification {
    return data[indexPath.row]
  }
  
  func update(with data: [Certification]) {
    self.data = data
  }
}
