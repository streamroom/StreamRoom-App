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

class SearchViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var userSearch: PMSuperButton!
    @IBOutlet weak var streamroomButton: PMSuperButton!
    @IBOutlet weak var userButton: PMSuperButton!
    
    @IBOutlet weak var searchBar: MFTextField!
    
    @IBOutlet weak var resultTableView: UITableView!
    
    var foundStreams: [Streamroom] = []
    var foundUsers: [PFUser] = []
    
    var userSelect: Bool = false
    var streamSelect: Bool = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        resultTableView.dataSource = self
        searchBar.addTarget(self, action: #selector(performSearch), for: UIControl.Event.editingDidBegin)
        
    }
    
    func checkSearchOptions() {
        
    }
    
    @objc func performSearch() {
        let query = searchBar.text
        if userSearch.isSelected && userButton.isSelected {
            getSearchResults(search: query!)
            getUserResults(search: query!)
        } else if userButton.isSelected {
            getUserResults(search: query!)
        } else if userSearch.isSelected {
            getSearchResults(search: query!)
        } else {
            getSearchResults(search: query!)
            getUserResults(search: query!)
        }
        
    }
    
    func getSearchResults(search: String) {
        let streamQuery = Streamroom.query()
        streamQuery?.whereKey("isPrivate", equalTo: false)
        streamQuery?.whereKey("name", contains: search)
        streamQuery?.includeKey("owner")
        streamQuery?.includeKey("name")
        
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String = ""
        if section == 0 {
            title = "Streamrooms"
        }
        if section == 1 {
            title = "Users"
        }
        return title
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        if section == 0 {
            rows = foundStreams.count
        }
        if section == 0 {
            rows = foundUsers.count
        }
        return rows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let streamCell = resultTableView.dequeueReusableCell(withIdentifier: "SearchStreamCell", for: indexPath) as! SearchStreamCell
            let streamRoom = foundStreams[indexPath.row]
            streamCell.streamroomName.text = streamRoom.name!
            return streamCell
        default:
            let userCell = resultTableView.dequeueReusableCell(withIdentifier: "SearchUserCell", for: indexPath) as! SearchUserCell
            return userCell
        }
    }
}
