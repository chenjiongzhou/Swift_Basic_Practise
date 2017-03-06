//
//  DetailsViewController.swift
//  Hello_Swift
//
//  Created by jiong23 on 2017/2/18.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer

class DetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, APIControllerProtocol {
    
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    
    var album: Album?
    var tracks = [Track]()
    lazy var api: APIController = APIController.init(delegate: self)
    var mediaPlayer: MPMoviePlayerController = MPMoviePlayerController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        let imgData = NSData.init(contentsOf: NSURL.init(string: (self.album?.largeImageURL)! as String) as! URL);
//        if let imgData = NSData.init(contentsOfFile: (self.album?.largeImageURL)!) {
            albumCover.image = UIImage.init(data: imgData as! Data)
//        } else {
//            albumCover.image = UIImage.init(named: "egg")
//        }
        
        if self.album != nil {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            api.lookupAlbum(collectionId: (self.album?.collectionId)!)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell") as! TrackCell
        let track = tracks[indexPath.row]
        cell.titleLabel.text = track.title
//        cell.playIcon.text = "YOUR_Play_ICON"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let track = tracks[indexPath.row]
        mediaPlayer.stop()
        mediaPlayer.contentURL = NSURL.init(string: track.previewUrl) as URL!
        mediaPlayer.play()
        if let cell = tableView.cellForRow(at: indexPath) as? TrackCell {
//            cell.playIcon.setImage(UIImage.init(named: "egg"), for: UIControlState.normal)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.25) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    func didReceiveAPIResults(results: NSArray) {
        DispatchQueue.main.async { 
            self.tracks = Track.tracksWithJSON(result: results)
            self.tracksTableView.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}
