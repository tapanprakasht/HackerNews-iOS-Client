//
//  StoryManager.swift
//  HackerNews
//
//  Created by Prakash T, Tapan on 28/04/17.
//  Copyright © 2017 Prakash T, Tapan. All rights reserved.
//

import Foundation

protocol StoryManagerDelegate {
  func getData(storyIds:[String],topStoryDetails:[TopStoryDetails])
}

class StoryManager: NetworkManagerDelegate {
  let networkManager: NetworkManager!
  var storyIds:[String]!
  var storyDetails:[TopStoryDetails]!
  var delegate: StoryManagerDelegate?
  var storyManagerDelegate: StoryManagerDelegate?
  var requestCount:Int
  
  init() {
    self.networkManager = NetworkManager()
    storyIds = []
    storyDetails = []
    requestCount = 0
  }
  
  func getTopStoriesId() {
    let url = "https://hacker-news.firebaseio.com/v0/topstories.json"
    networkManager.delegate = self
    networkManager.sendRequest(withURL: URL(string: url)!, requestType: .getStoryId)
  }
  
  fileprivate func getStoryDetails(storyId: [String]) {
    for id in storyId[0...10] {
      let url = "https://hacker-news.firebaseio.com/v0/item/\(id).json"
      networkManager.sendRequest(withURL: URL(string: url)!, requestType: .getStoryDetais)
    }
  }
  
  func getResults(result: String, responseType: responseType) {
    if(responseType == .storyIds) {
      var result = result.replacingOccurrences(of: "[", with: "")
      result = result.replacingOccurrences(of: "]", with: "")
      storyIds = result.components(separatedBy: ",")
      getStoryDetails(storyId: storyIds)
    } else {
      
      let data = result.data(using: .utf8)
      do {
        let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
        if let title = json["title"] as? String,
          let storyId = json["id"] as? Int,
          let author = json["by"] as? String,
          let score = json["score"] as? Int,
          let time = json["time"] as? Int,
          let url = json["url"] as? String {
          
//            print("Start of story \(title)")
//            print(title)
//            print(storyId)
//            print(author)
//            print(score)
//            print("End of story \(title)")
          
          let topStoryDetails = TopStoryDetails(storyId: storyId, author: author, score: score, time: time, title: title, url: url)
          storyDetails.append(topStoryDetails)
          requestCount += 1
          if(requestCount == 10) {
            storyManagerDelegate?.getData(storyIds: storyIds, topStoryDetails: storyDetails)
          }
        }
      } catch {
        print("Error in parsing JSON")
      }
      
    }
  }
  
  func getError(error: String) {
    print(error)
  }
}
