//
//  ArtistSelectViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/23/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Alamofire

class ArtistSelectViewController: UIViewController {
    
    var genres: [String] = []
    var artists: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getArtists { (success) in
            print("didn't crash")
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
        
        let headers: HTTPHeaders = ["Authorization": "Bearer BQDG7wKZ_5JJTBg_EFoi_2aR_oWDQ7SwuNy907eXyEZb0Clxd_HgaQLlLj-43THwXvkJIOjNdtuxDKmI-0U8hCutAXgkjh8FfXfs5uhlWQeWa9hTFxXE1fzZlSPyM6hUff8Z7_becgeCXt6xY4E", "Accept": "application/json", "Content-Type": "application/json"]
        
        
        Alamofire.request( artistURL, headers: headers).responseJSON { response in
            guard let data = response.result.value as? [[String:Any]] else {
                return
            }
            
            
            
            
        }
        
//        request(artistURL, method: .get, headers: headers).responseJSON { (response) in
//            switch response.result {
//            case .failure(let error):
//                completion(nil, error)
//                return
//            case .success:
//                guard let data = response.result.value as? [[String:Any]] else {
//                    print("Failed to get response array.")
//                    let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Failed to parse tweets"])
//                    completion(nil, error)
//                    return
//                }
//
//                print("JSON: \(data)")
//                completion(["test1","test2","test3"], nil)
////                if let dataDictionary = data["tracks"] as! [String:Any] {
////
////                }
//            }
//        }
    }
}
