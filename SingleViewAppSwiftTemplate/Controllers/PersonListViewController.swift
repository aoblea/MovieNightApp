//
//  PersonListViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/24/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class PersonListViewController: UITableViewController {

  // MARK: - IBOutlet
  @IBOutlet weak var doneButton: UIBarButtonItem!
  
  // MARK: - Properties
  var selectedPeople: [Person] = [] {
    didSet {
      if selectedPeople.count > 4 {
        doneButton.isEnabled = true
      } else {
        doneButton.isEnabled = false
      }
    }
  }
  let dataSource = PersonListDataSource()
  var delegate: UserSelectionsDelegate?
  
  // MARK: - IBAction methods
  @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    if selectedPeople.count == 5 {
      // change user to finish status and change button image
      delegate?.userSelectedPeople(selectedPeople)
      delegate?.checkUsersStatus()
      
      navigationController?.popToRootViewController(animated: true) // goes back to root aka homeviewcontroller
    }
  }
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()

    setupView()
    setupTableView()
  }
  
  func setupView() {
    self.title = "Select 5 People"
    doneButton.isEnabled = false
  }
  
  func setupTableView() {
    tableView.allowsMultipleSelection = true
    tableView.delegate = self
    tableView.dataSource = dataSource
  }

}

// MARK: - Table view delegate methods
extension PersonListViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let person = dataSource.object(at: indexPath)
    if selectedPeople.count < 5 {
      selectedPeople.append(person)
      self.title = "\(selectedPeople.count) of 5 selected" // update title
    }
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    selectedPeople.removeAll { (person) -> Bool in
      if person.name == dataSource.object(at: indexPath).name {
        return true
      }
      return false
    }
    
    // update title
    if selectedPeople.isEmpty {
      self.title = "Select 5 People"
    } else {
      self.title = "\(selectedPeople.count) of 5 selected"
    }
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if selectedPeople.count == 5 {
      return nil
    } else {
      return indexPath
    }
  }
}
