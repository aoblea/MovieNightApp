//
//  GenreListViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/24/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class GenreListViewController: UITableViewController, Alertable {
  
  // MARK: - IBOutlet
  @IBOutlet weak var nextButton: UIBarButtonItem!
  
  // MARK: - Properties
  var selectedGenres: [Genre] = [] {
    didSet {
      if selectedGenres.count > 4 {
        nextButton.isEnabled = true
      } else {
        nextButton.isEnabled = false
      }
    }
  }
  lazy var client = MovieNightClient()
  let dataSource = GenreListDataSource()
  var delegate: UserSelectionsDelegate?
  
  // MARK: - IBAction methods
  @IBAction func nextButtonPressed(_ sender: UIBarButtonItem) {
    performSegue(withIdentifier: "showCertificationList", sender: self)
  }
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    setupTableView()
  }
  
  func setupView() {
    self.title = "Select 5 Genres"
    navigationController?.navigationBar.tintColor = .white
    nextButton.isEnabled = false
  }
  
  func setupTableView() {
    tableView.allowsMultipleSelection = true
    tableView.delegate = self
    tableView.dataSource = dataSource
  }
  
}

// MARK: - Table view delegate methods
extension GenreListViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let genre = dataSource.object(at: indexPath)
    if selectedGenres.count < 5 {
      selectedGenres.append(genre)
      self.title = "\(selectedGenres.count) of 5 selected" // update title
    }
  }
  
  override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    selectedGenres.removeAll { (genre) -> Bool in
      if genre.name == dataSource.object(at: indexPath).name {
        return true
      }
      return false
    }
    
    // updates title
    if selectedGenres.isEmpty {
      self.title = "Select 5 Genres"
    } else {
      self.title = "\(selectedGenres.count) of 5 selected"
    }
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    // if user tries to select more than 5 genres, nothing will happen.
    if selectedGenres.count == 5 {
      return nil
    } else {
      return indexPath
    }
  }
}

// MARK: - Navigation
extension GenreListViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showCertificationList" {
      let certificationListController = segue.destination as? CertificationListViewController
      delegate?.userSelectedGenres(selectedGenres)
      
      guard let certificationLC = certificationListController else { return }
      certificationLC.delegate = self.delegate
      DispatchQueue.main.async {
        // fetch certification list from client
        self.client.certificationList { (result) in
          switch result {
          case .success(let list):
            // US List
            let usCertifications = list.certifications["US"]
            guard let certifications = usCertifications else { return }
              certificationLC.dataSource.update(with: certifications)
              certificationLC.tableView.reloadData()
              
          case .failure(let error):
              self.showAlert(title: "An internal error occurred.", message: "Error: \(error)", viewController: self)
          }
        }
      }
    }
  }
}
