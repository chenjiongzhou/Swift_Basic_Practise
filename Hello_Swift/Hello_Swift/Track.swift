//
//  Track.swift
//  Hello_Swift
//
//  Created by jiong23 on 2017/2/18.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import Foundation

struct Track {
    let title: String
    let price: String
    let previewUrl: String
    
    init(title: String, price: String, previewUrl: String) {
        self.title = title
        self.price = price
        self.previewUrl = previewUrl
    }
    
    static func tracksWithJSON(result: NSArray) -> [Track] {
        var tracks = [Track]()
        if result.count > 0 {
            for track in result {
                let trackDict = track as! NSDictionary
                if let kind = trackDict["kind"] as? String {
                    if kind == "song" {
                        var trackPrice = trackDict["collectionPrice"] as? String
                        var trackTitle = trackDict["trackCensoredName"] as? String
                        var trackPreviewUrl = trackDict["previewUrl"] as? String
                        
                        if trackTitle == nil {
                            trackTitle = "Unknown"
                        }
                        if trackPrice == nil {
                            trackPrice = "?"
                        }
                         if trackPreviewUrl == nil {
                            trackPreviewUrl = ""
                        }
                        
                        let track = Track.init(title: trackTitle!, price: trackPrice!, previewUrl: trackPreviewUrl!)
                        tracks.append(track)
                    }
                }
            }
        }
        
        return tracks
    }
}
