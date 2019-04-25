//
//  HomeViewController.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/4/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var streamTableView: UITableView!
    
    var streamrooms: [Streamroom] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        streamTableView.dataSource = self
        streamTableView.estimatedRowHeight = 300
        streamTableView.rowHeight = UITableView.automaticDimension
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
                self.streamTableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return streamrooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = streamTableView.dequeueReusableCell(withIdentifier: "StreamCell", for: indexPath) as! StreamCell
        let stream = streamrooms[indexPath.row]
        cell.stream = stream
        cell.streamName.text = stream.name
        let imageData = stream.image
        imageData?.getDataInBackground(block: { (data, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Image was found!")
                cell.streamImage.image = UIImage(data: data!)
                self.streamTableView.reloadData()
            }
        })
        
        
        return cell
    }
    
    @IBAction func onCreateStream(_ sender: Any) {
        self.performSegue(withIdentifier: "createStream", sender: nil)
    }
}
