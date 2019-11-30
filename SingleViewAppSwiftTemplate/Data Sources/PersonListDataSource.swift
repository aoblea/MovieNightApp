//
//  PersonListDataSource.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/27/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class PersonListDataSource: NSObject, UITableViewDataSource {

  private var people = [Person]()
  
  override init() {
    super.init()
  }
  
  // MARK: - Table view data source methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return people.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
    let person = object(at: indexPath)
    cell.textLabel?.text = person.name
    
    return cell
  }
  
  // MARK: - Helper methods
  func object(at indexPath: IndexPath) -> Person {
    return people[indexPath.row]
  }
  
  func update(with data: [Person]) {
    self.people = data
  }
}
