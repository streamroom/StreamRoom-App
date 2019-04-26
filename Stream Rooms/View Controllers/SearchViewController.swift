//
//  SearchViewController.swift
//  Stream Rooms
//
//  Created by Stephon Fonrose on 4/25/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse
import PMSuperButton
import TweeTextField
import MaterialTextField

class SearchViewController: UIViewController {

    @IBOutlet weak var userSearch: PMSuperButton!
    @IBOutlet weak var searchBar: MFTextField!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var foundStreams: [Streamroom] = []
    var foundUsers: [PFUser] = []
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    func getSearchResults(search: String) {
        let streamQuery = Streamroom.query()
        streamQuery?.whereKey("name", contains: search)
        
        streamQuery?.findObjectsInBackground { (rooms ,error) in
            if let rooms = rooms {
                print("Posts were found!")
                self.foundStreams = rooms as! [Streamroom]
                self.resultTableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func getUserResults(search: String) {
        let userQuery = PFUser.query()
        userQuery?.whereKey("username", contains: search)
        
        userQuery?.findObjectsInBackground(block: { (users, error) in
            if let users = users {
                print("Users were found")
                self.foundUsers = users as! [PFUser]
                self.resultTableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        })
    }
    
//    func numb
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        <#code#>
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        <#code#>
//    }
}
