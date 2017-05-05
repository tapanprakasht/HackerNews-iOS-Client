//
//  NetworkManager.swift
//  HackerNews
//
//  Created by Prakash T, Tapan on 28/04/17.
//  Copyright © 2017 Prakash T, Tapan. All rights reserved.
//

import Foundation

enum responseType {
  case storyIds
  case storyDetails
}

enum requestType {
  case getStoryId
  case getStoryDetais
}

protocol NetworkManagerDelegate {
  func getResults(result: String, responseType: responseType)
  func getError(error: String)
}

class NetworkManager {
  var delegate: NetworkManagerDelegate?
  
  func sendRequest(withURL Url: URL,requestType: requestType) {
    
    let defaultSession = URLSession(configuration: .default)
    let urlRequest:URLRequest = URLRequest(url: Url)
    let dataTask = defaultSession.dataTask(with: urlRequest as URLRequest) { (data, response, error) in
      if let error = error {
        print(error)
      } else if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          let dataString = String(data: data!, encoding: String.Encoding.utf8)
          if let dataString = dataString {
            
            if(requestType == .getStoryId) {
              self.delegate?.getResults(result: dataString,responseType: .storyIds)
            }else {
              self.delegate?.getResults(result: dataString,responseType: .storyDetails)
            }
            
          } else {
            print("Error")
          }
        }
      }
    }
    dataTask.resume()
  }
  
}
