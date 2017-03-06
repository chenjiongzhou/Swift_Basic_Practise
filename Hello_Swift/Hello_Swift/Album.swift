//
//  Album.swift
//  Hello_Swift
//
//  Created by jiong23 on 2017/2/18.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import Foundation

struct Album {
    let title: String
    let price: String
    let thumbnailImageURL: String
    let largeImageURL: String
    let itemURL: String
    let artistURL: String
    let collectionId: Int
    
    init(name: String, price: String, thumbnailImageURL: String, largeImageURL: String, itemURL: String, artistURL: String, collectionId: Int) {
        self.title = name
        self.price = price
        self.thumbnailImageURL = thumbnailImageURL
        self.largeImageURL = largeImageURL
        self.itemURL = itemURL
        self.artistURL = artistURL
        self.collectionId = collectionId
    }
    
    static func albumsWithJSON(results: NSArray) -> [Album] {
        var albums = [Album]()
        
        if results.count > 0 {
        
            for result in results {
                let resultDict = result as! NSDictionary
                
                var name = resultDict["trackName"] as? String
                if name == nil{
                    name = resultDict["collectionName"] as? String
                }
                
                var price = resultDict["formattedPrice"]
                if  price == nil {
//                    let priceFloat: Float? = resultDict["collectionPrice"] as? Float
//                    let nf: NumberFormatter = NumberFormatter()
//                    nf.maximumFractionDigits = 2
//                    if priceFloat != nil {
//                        price = "$\(nf.string(from: NSNumber.init(value: priceFloat)))"
//                    }
                    price = "no price"
                }
                
                let thumbnailURL = resultDict["artworkUrl60"] as? String ?? ""
                let imageURL = resultDict["artworkUrl100"] as? String ?? ""
                let artistURL = resultDict["artistViewUrl"] as? String ?? ""
                
                var itemURL = resultDict["collectionViewUrl"] as? String
                if itemURL == nil {
                    itemURL = resultDict["trackViewUrl"] as? String
                }
                
                let collectionId = resultDict["collectionId"] as? Int
                
                let newAlbum = Album.init(name: name!, price: price as! String, thumbnailImageURL: thumbnailURL, largeImageURL: imageURL, itemURL: itemURL!, artistURL: artistURL, collectionId: collectionId!)
                albums.append(newAlbum)
            }
        }
        return albums
    }
}
