//
//  ViewController.swift
//  Hello_Swift
//
//  Created by jiong23 on 2017/2/12.
//  Copyright © 2017年 Chenjz. All rights reserved.
//

import UIKit
import AdSupport

let kCellIdentifier: String = "SearchResultCell"

class SearchResultsViewController: UIViewController , UITableViewDelegate, UITableViewDataSource , APIControllerProtocol{

    @IBOutlet weak var appsTableView: UITableView!
    var albums = [Album]()
    var api: APIController!
    var imageCache = [String : UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        api = APIController.init(delegate: self)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        api.searchItunesFor(searchTerm: "Angry Birds")
        
        let adId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        print("idfa - \(adId)")
    }
    
    // MARK: talbeView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier) as! UITableViewCell
        // what's the difference between the two method
        
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "MyTestCell")
        
        let album = albums[indexPath.row]
        cell.detailTextLabel?.text = album.price
        cell.textLabel?.text = album.title
        cell.imageView?.image = UIImage.init(named: "joker")
    
//         if let rowData = albums[indexPath.row] as? Album,
//            let trackName = rowData["trackName"] as? String,
//            let urlString = rowData["artworkUrl60"] as? String,
//            let imgURL = NSURL.init(string: urlString),
//            let formattedPrice = rowData["formattedPrice"] as? String {
//                cell.textLabel?.text = trackName
//                cell.detailTextLabel?.text = formattedPrice
//                cell.imageView?.image = UIImage.init(named: "egg")
////                cell.imageView?.image = UIImage.init(data: imgData as Data)
        
            let thumbnailURLString = album.thumbnailImageURL
            let thumbnailURL = NSURL.init(string: thumbnailURLString)
            if let img = imageCache[thumbnailURLString] {
                cell.imageView?.image = img
            } else {

                let request = URLRequest.init(url: thumbnailURL as! URL)
                URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                    if (error == nil) {
                        let image = UIImage.init(data: data!)
                        self.imageCache[thumbnailURLString] = image
                        DispatchQueue.main.async(execute: { 
                            if let cellToUpdate = tableView.cellForRow(at: indexPath) {
                                cellToUpdate.imageView?.image = image
                            }
                        })
                    } else {
                        print("Error: \(error?.localizedDescription)")
                    }
                }).resume()
  
            }
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if let rowData = self.tableData[indexPath.row] as? NSDictionary,
//           let name  = rowData["trackName"] as? String,
//           let formattedPrice = rowData["formattedPrice"] as? String {
//                let alert = UIAlertController.init(title: name, message: formattedPrice, preferredStyle: .alert)
//                alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.25) { 
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
    
    func didReceiveAPIResults(results: NSArray) {
        
        DispatchQueue.main.async { 
            self.albums = Album.albumsWithJSON(results: results)
            self.appsTableView!.reloadData()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let detailsViewController: DetailsViewController = segue.destination as? DetailsViewController {
            let albumIndex = appsTableView!.indexPathForSelectedRow!.row
            let selectedAlbum = self.albums[albumIndex]
            detailsViewController.album = selectedAlbum
        }
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

