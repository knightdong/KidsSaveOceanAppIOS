//
//  HomeTableViewController.swift
//  KidsSaveOcean
//
//  Created by Maria Soboleva on 9/25/18.
//  Copyright © 2018 KidsSaveOcean. All rights reserved.
//

import UIKit
import Firebase

final class HomeTableViewController: UITableViewController {

  private let homeCellIdenteficator = "homeViewCellIdentificator"
  private let scoreCellIdenteficator = "scoreViewCellIdentificator"
  
  private lazy var viewModel = CountryLetterScoresViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.backgroundColor = UIColor.backgroundGray
    tableView.isScrollEnabled = true
    tableView.bounces = false
    tableView.isUserInteractionEnabled = true
    tableView.separatorStyle = .none
    tableView.separatorColor = UIColor.backgroundGray
    tableView.showsVerticalScrollIndicator = false
    tableView.rowHeight = view.bounds.height * 156/667 // (for keeping design proportions iPhone8 for cell)
    tableView.dataSource = self
    tableView.delegate   = self
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return HomeViewData.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let staticData = BaseTableViewData(dictionary: HomeViewData[indexPath.row])
    
    if indexPath.row == 3 {
      let cell = tableView.dequeueReusableCell(withIdentifier: scoreCellIdenteficator, for: indexPath) as! HomeScoreTableViewCell
      viewModel.fetchCountryScores {
        let scores = self.viewModel.topCountryScores()
        
        if scores.count > 0 {
          cell.country1NumLabel.text = "1"
          cell.country1Label.text = scores[0].country
          cell.country1ScoreLabel.text = String( scores[0].numberOfLetters )
        }
        
        if scores.indices.contains(1) {
          cell.country2NumLabel.text = "2"
          cell.country2Label.text = scores[1].country
          cell.country2ScoreLabel.text = String( scores[1].numberOfLetters )
        }
        
        if scores.indices.contains(2) {
          cell.country3NumLabel.text = "3"
          cell.country3Label.text = scores[2].country
          cell.country3ScoreLabel.text = String( scores[2].numberOfLetters )
        }
      }
      return cell
      
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdenteficator, for: indexPath) as! HomeTableViewCell
      cell.imageCover.image =  staticData?.image
      cell.titleLabel.text = staticData?.title
      cell.subTitleLabel.text = staticData?.subTitle
      
      if indexPath.row == 2 { // TODO: need a better way
        cell.titleLabel.textColor = .black
        cell.subTitleLabel.textColor = .black
      }
      return cell
    }
  }
  
  func setScoresLavel() {
    
  }
  
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 8
  }
  
  override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 8
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      tabBarController?.selectedIndex = 1
      
    case 1:
      tabBarController?.selectedIndex = 3
      
      let navController = tabBarController?.selectedViewController as! UINavigationController
      let resourcesVC = navController.childViewControllers.first as! KSOResourcesTableViewController
      resourcesVC.showCountryContactView()
      
    case 2, 3:
      tabBarController?.selectedIndex = 4
      let mapVC =  (tabBarController?.selectedViewController as! MapViewController)
      mapVC.segmentControl.selectedSegmentIndex = indexPath.row == 2 ? 0 : 1
      mapVC.didChangeSegment(mapVC.segmentControl)
      
    default:
      return
    }

  }
  
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    return viewForHeaderAndFooter()
  }
  
  override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    return viewForHeaderAndFooter()
  }
  
  private func viewForHeaderAndFooter() -> UIView {
    let viewH = UIView()
    viewH.backgroundColor = .white
    return viewH
  }
  

}
