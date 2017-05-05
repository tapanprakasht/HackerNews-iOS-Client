//
//  ViewController.swift
//  HackerNews
//
//  Created by Prakash T, Tapan on 28/04/17.
//  Copyright © 2017 Prakash T, Tapan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,StoryManagerDelegate,UITableViewDataSource,UITableViewDelegate {

  var tableView: UITableView!
  var activityIndicator: UIActivityIndicatorView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView = UITableView(frame: CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: self.view.frame.width, height: self.view.frame.height))
    activityIndicator = UIActivityIndicatorView(frame: CGRect(x: self.view.frame.width/2 - 30, y: self.view.frame.height/2 - 30, width: 60, height: 60))
    activityIndicator.backgroundColor = UIColor.yellow
    
    self.view.addSubview(activityIndicator)
    self.view.addSubview(tableView)
    activityIndicator.startAnimating()
    let storyManager = StoryManager()
    storyManager.storyManagerDelegate = self
    storyManager.getTopStoriesId()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
    if(cell == nil) {
      cell = UITableViewCell()
    }
    return cell!
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func getData(storyIds: [String], topStoryDetails: [TopStoryDetails]) {
    dump(storyIds)
    dump(topStoryDetails)
//    print(topStoryDetails)
//      print(topStoryDetails[0].title)
//      DispatchQueue.main.async {
//        self.activityIndicator.stopAnimating()
//      }
  }
}

