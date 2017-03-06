//
//  APIController.swift
//  Hello_Swift
//
//  Created by jiong23 on 2017/2/18.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import Foundation

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSArray)
}

class APIController {
    // 加?可选的delegate, 不加就已经是初始化了
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol) {
        self.delegate = delegate
    }
    
    func get(urlPath: String)  {
        let url = NSURL.init(string: urlPath)
        let session = URLSession.shared
        let request = URLRequest(url: url as! URL)
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            print("task Completion")
            do {
                if let data = data,
                    let json = try JSONSerialization.jsonObject(with: data , options: .allowFragments) as? [String: Any] {
                    
                    if let results: NSArray = json["results"] as? NSArray {
                        self.delegate.didReceiveAPIResults(results: results)
                        
                    }
                }
                
            } catch {
                print("Error deserializing JSON: \(error)")
            }
            
        })
        task.resume()
    }

    func searchItunesFor(searchTerm: String) {
        let itunesSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.caseInsensitive, range: nil)
        if let escapedSearchTerm = itunesSearchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&&media=music&entity=album"
            get(urlPath: urlPath)
        }
        
    }
    
    func lookupAlbum(collectionId: Int) {
        get(urlPath: "https://itunes.apple.com/lookup?id=\(collectionId)&entity=song")
    }
}
