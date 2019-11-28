//
//  CertificationListViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/24/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class CertificationListViewController: UITableViewController, Alertable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var nextButton: UIBarButtonItem!

  // MARK: - Properties
  var selectedCertifications: [Certification] = [] {
    didSet {
      if selectedCertifications.count > 2 {
        nextButton.isEnabled = true
      } else {
        nextButton.isEnabled = false
      }
    }
  }
  lazy var client = MovieNightClient()
  let dataSource = CertificationListDataSource()
  var delegate: UserSelectionsDelegate?
  
  // MARK: - IBAction methods
  @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "showPersonList", sender: self)
  }
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupTableView()
  }
  
  func setupView() {
    self.title = "Select 3 Content Ratings"
    nextButton.isEnabled = false
  }
  
  func setupTableView() {
    tableView.allowsMultipleSelection = true
    tableView.delegate = self
    tableView.dataSource = dataSource
  }

}

// MARK: - Table view delegate methods
extension CertificationListViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let certification = dataSource.object(at: indexPath)
    if selectedCertifications.count < 3 {
      selectedCertifications.append(certification)
      self.title = "\(selectedCertifications.count) of 3 selected" // update title
    }
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    selectedCertifications.removeAll { (certification) -> Bool in
      if certification.certification == dataSource.object(at: indexPath).certification {
        return true
      }
      return false
    }
    
    // update title
    if selectedCertifications.isEmpty {
      self.title = "Select 3 Content Ratings"
    } else {
      self.title = "\(selectedCertifications.count) of 3 selected"
    }
  }

  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // if user tries to select more than 3 ratings, nothing will happen.
    if selectedCertifications.count == 3 {
      return nil
    } else {
      return indexPath
    }
  }
}

// MARK: - Navigation
extension CertificationListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showPersonList" {
      let personListController = segue.destination as? PersonListViewController
      delegate?.userSelectedCertifications(selectedCertifications)
      
      guard let personLC = personListController else { return }
        personLC.delegate = self.delegate
      
        DispatchQueue.main.async {
          self.client.people { (result) in
            switch result {
            case .success(let list):
              let people = list.results // just the first page of people
              personLC.dataSource.update(with: people)
              personLC.tableView.reloadData()
            case .failure(let error):
              self.showAlert(title: "An internal error occurred.", message: "Error: \(error)", viewController: self)
            }
          }
        }
    } else {
      print("Segue identifier does not match")
    }
  }
  
}
