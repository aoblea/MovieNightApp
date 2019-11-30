//
//  HomeViewController.swift
//  Movie Night App
//
//  Created by Arwin Oblea on 11/19/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
// create a delegate in order to store user's picks
protocol UserSelectionsDelegate: class {
  func userSelectedGenres(_ genres: [Genre])
  func userSelectedCertifications(_ certifications: [Certification])
  func userSelectedPeople(_ people: [Person])
  func checkUsersStatus()
}

class HomeViewController: UIViewController, Alertable {
  
  // MARK: - IBOutlets
  @IBOutlet weak var firstUserButton: UIButton!
  @IBOutlet weak var secondUserButton: UIButton!
  @IBOutlet weak var viewResultsButton: UIButton!
   
  // MARK: - Properties
  let selectedImage = UIImage(named: "bubble-selected")
  let emptyImage = UIImage(named: "bubble-empty")
  var firstUser = User() {
    didSet {
      if firstUser.isFinish == true {
        firstUserButton.setBackgroundImage(selectedImage, for: .normal)
        firstUserButton.isEnabled = false
      } else {
        firstUserButton.setBackgroundImage(emptyImage, for: .normal)
        firstUserButton.isEnabled = true
      }
    }
  }
  var secondUser = User() {
    didSet {
      if secondUser.isFinish == true {
        secondUserButton.setBackgroundImage(selectedImage, for: .normal)
        secondUserButton.isEnabled = false
      } else {
        secondUserButton.setBackgroundImage(emptyImage, for: .normal)
        secondUserButton.isEnabled = true
      }
    }
  }
  lazy var client = MovieNightClient()
  
  // MARK: - Viewdidload
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    viewResultsButton.isEnabled = false
    viewResultsButton.alpha = 0.5
  }
  
  func setupView() {
    self.title = "Movie Night App"
    navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    navigationController?.navigationBar.barTintColor = UIColor.AppColor.lightRed
    navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearSelections))
    navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.white
  }
  
  @objc func clearSelections() {
    // Resets selections
    firstUser = User()
    secondUser = User()
    viewResultsButton.isEnabled = false
    viewResultsButton.alpha = 0.5
    
    showAlert(title: "Selections have been cleared!", message: "Click on bubble to select your preferences.", viewController: self)
  }
  
  // MARK: - IBActions
  @IBAction func beginSelecting(_ sender: UIButton) {
    if sender.tag == 1 {
      firstUser.isSelected = true
      secondUser.isSelected = false
    } else if sender.tag == 2 {
      firstUser.isSelected = false
      secondUser.isSelected = true
    }
  }
}

extension HomeViewController {
  // MARK: - Helper Methods
  // FIXME: - Needs refactoring, maybe create a generic function to remove duplicates from an array
  // Made Genre, Certification, Person conform to Equatable in order to filter out duplicates from the array
  func filterGenresFor(first: User, second: User) -> [Genre] {
    let combinedGenres = first.genres + second.genres
    var filteredGenres: [Genre] = []
    for genre in combinedGenres {
      if !filteredGenres.contains(genre) {
        filteredGenres.append(genre)
      }
    }
    return filteredGenres
  }
  
  func filterCertificationsFor(first: User, second: User) -> [Certification] {
    let combinedCertifications = first.certification + second.certification
    var filteredCertifications: [Certification] = []
    for certification in combinedCertifications {
      if !filteredCertifications.contains(certification) {
        filteredCertifications.append(certification)
      }
    }
    return filteredCertifications
  }
  
  func filterPeopleFor(first: User, second: User) -> [Person] {
    let combinedPeople = first.people + second.people
    var filteredPeople: [Person] = []
    for person in combinedPeople {
      if !filteredPeople.contains(person) {
        filteredPeople.append(person)
      }
    }
    return filteredPeople
  }
}

// MARK: - UserSelections delegate methods
extension HomeViewController: UserSelectionsDelegate {
  func userSelectedGenres(_ genres: [Genre]) {
    if firstUser.isSelected {
      firstUser.genres.append(contentsOf: genres)
    } else if secondUser.isSelected {
      secondUser.genres.append(contentsOf: genres)
    }
  }
  
  func userSelectedCertifications(_ certifications: [Certification]) {
    if firstUser.isSelected {
      firstUser.certification.append(contentsOf: certifications)
    } else if secondUser.isSelected {
      secondUser.certification.append(contentsOf: certifications)
    }
  }
  
  func userSelectedPeople(_ people: [Person]) {
    if firstUser.isSelected {
      firstUser.people.append(contentsOf: people)
      firstUser.isFinish = true
    } else if secondUser.isSelected {
      secondUser.people.append(contentsOf: people)
      secondUser.isFinish = true
    }
  }
  
  func checkUsersStatus() {
    if firstUser.isFinish == true && secondUser.isFinish == true {
      viewResultsButton.isEnabled = true
      viewResultsButton.alpha = 1.0
    }
  }
}

// MARK: - Navigation
extension HomeViewController {
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showGenreList" {
      // show genre list
      let genreListController = segue.destination as? GenreListViewController
      if let genreLC = genreListController {
        
        DispatchQueue.main.async {
          // fetch genres to populate list
          self.client.genreList { (result) in
            switch result {
            case .success(let list):
              let genres = list.genres
              genreLC.delegate = self
              genreLC.dataSource.update(with: genres)
              genreLC.tableView.reloadData()
            case .failure(let error):
              self.showAlert(title: "An internal error occurred.", message: "Error: \(error)", viewController: self)
            }
          }
        }
        
      }
    } else if segue.identifier == "showResultList" {
      // show results and fetch discover results based on both users selections
      let resultListController = segue.destination as? ResultsListViewController
      guard let resultLC = resultListController else { return }
      
        DispatchQueue.main.async {
          let genres = self.filterGenresFor(first: self.firstUser, second: self.secondUser)
          let certifications = self.filterCertificationsFor(first: self.firstUser, second: self.secondUser)
          let people = self.filterPeopleFor(first: self.firstUser, second: self.secondUser)
          self.client.discoverMovies(certification: certifications, withPeople: people, withGenres: genres) { (result) in
            switch result {
            case .success(let list):
              let movies = list.results
              resultLC.dataSource.update(with: movies)
              resultLC.tableView.reloadData()
            case .failure(let error):
              self.showAlert(title: "An internal error occurred.", message: "Error: \(error)", viewController: self)
            }
          }
        }
    }
  }
}
