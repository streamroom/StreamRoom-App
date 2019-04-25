//
//  HomeViewController.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/4/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var streamCollectionView: UICollectionView!
    
    var streamrooms: [Streamroom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        streamCollectionView.dataSource = self
        
        let layout = streamCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsPerLine: CGFloat = 1
        let interItemSpacingTotal = layout.minimumInteritemSpacing * (cellsPerLine - 1)
        let width = (streamCollectionView.frame.size.width / cellsPerLine) - (interItemSpacingTotal / cellsPerLine)
        layout.itemSize = CGSize(width: width, height: width * 2 / 3)
        getStreams()
        
        
    }
    
    func getStreams() {
        let query = Streamroom.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("owner")
        query?.includeKey("createdAt")
        query?.includeKey("image")
        query?.limit = 20
        
        query?.findObjectsInBackground { (rooms ,error) in
            if let rooms = rooms {
                print("Posts were found!")
                self.streamrooms = rooms as! [Streamroom]
                self.streamCollectionView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return streamrooms.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = streamCollectionView.dequeueReusableCell(withReuseIdentifier: "StreamCell", for: indexPath) as! StreamCell
        cell.stream = streamrooms[indexPath.row]
        
        return cell
    }
    
    @IBAction func onCreateStream(_ sender: Any) {
        self.performSegue(withIdentifier: "createStream", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {/Users/jalejandre/Desktop/Assets.xcassets
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
