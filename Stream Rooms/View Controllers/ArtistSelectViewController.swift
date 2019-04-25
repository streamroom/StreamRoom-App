//
//  ArtistSelectViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse
import Alamofire
import PMSuperButton

class ArtistSelectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var genres: [String] = []
    var artists: [String] = []
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet weak var nextButton: PMSuperButton!
    
    var selectedArtists: [String] = []
    var _selectedCells: NSMutableArray = []

    @IBOutlet weak var artistTable: UITableView!
    
    let selectMore = UIAlertController(title: "No Selection!", message: "Select at least one artist.", preferredStyle: .actionSheet)
    let selectLess = UIAlertController(title: "Too Many Selections!", message: "Select no more than 10 genres.", preferredStyle: .actionSheet)
    
    let moreOK = UIAlertAction(title: "Ok", style: .cancel)
    let lessOK = UIAlertAction(title: "Ok", style: .cancel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistTable.dataSource = self
        artistTable.delegate = self
        getArtists { (success) in
            print("didn't crash")
        }
        artistTable.allowsMultipleSelection = true
        selectMore.addAction(moreOK)
        selectLess.addAction(lessOK)
        next()
        

    }
    
    func next() {
        nextButton.touchUpInside() {
            if self.selectedArtists.count == 0 {
                self.present(self.selectMore, animated: true)
            } else if self.selectedArtists.count > 10 {
                self.present(self.selectLess, animated: true)
            } else {
                let user = PFUser.current()
                user?.addObjects(from: self.selectedArtists, forKey: "astists")
                self.performSegue(withIdentifier: "newUserToHome", sender: nil)
            }
        }
    }
    
    func getArtists(completion: @escaping ([String]?) -> ()) {
        
        var genreString: String = ""
        
        for index in 0..<genres.count {
            if index == genres.count {
                genreString += genres[index]
            } else {
                genreString += genres[index]
                genreString += "%2C"
            }
        }
        
        let baseURLString = "https://api.spotify.com/v1/recommendations?seed_genres="
        
        let artistURL = URL(string: baseURLString + genreString)!
        
        let UAuth = UserDefaults.standard.string(forKey: "spotifyToken")
        
        let headers: HTTPHeaders = ["Authorization": "Bearer \(API)", "Accept": "application/json", "Content-Type": "application/json"]
        
        Alamofire.request( artistURL, headers: headers).responseJSON { response in
            guard let data = response.result.value as? [String:Any] else {
                return
            }
            
            let info = data["tracks"] as! NSArray
            for index in 0..<info.count{
                let array = info[index] as! NSDictionary
                let next = array["album"] as! NSDictionary
                let other = next["artists"] as! NSArray
                let mail = other[0] as! NSDictionary
                print(mail)
                let name = mail["name"] as! String
                
                self.artists.append(name)
                print(name)
            }
            self.artistTable.reloadData()
        }
    }
    
    func updateCount() {
        if selectedArtists.count > 0 {
            shareLabel.text = "\(selectedArtists.count) selected (Max 10)"
        } else {
            shareLabel.text = ""
        }
        
        UIView.animate(withDuration: 0.3) {
            self.shareLabel.sizeToFit()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = artistTable.dequeueReusableCell(withIdentifier: "ArtistCell", for: indexPath) as! ArtistCell
        
        cell.artistLabel.text = artists[indexPath.row]
        
        if _selectedCells.contains(indexPath) {
            cell.isSelected = true
            artistTable.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        } else {
            cell.isSelected = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _selectedCells.add(indexPath)
        let artist = artists[indexPath.row]
        selectedArtists.append(artist)
        updateCount()
        artistTable.reloadRows(at: [indexPath], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        _selectedCells.remove(indexPath)
        let artist = artists[indexPath.row]
        if let index = selectedArtists.firstIndex(of: artist) {
            print("Hello")
            selectedArtists.remove(at: index)
            updateCount()
            artistTable.reloadRows(at: [indexPath], with: .fade)
        }
        
        
        
    }
}
