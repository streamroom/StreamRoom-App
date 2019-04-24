//
//  SettingsViewController.swift
//  Stream Rooms
//
//  Created by Jorge Alejandre on 4/6/19.
//  Copyright © 2019 Jorge Alejandre. All rights reserved.
//

import UIKit
import Parse

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    
    
    var messages: [PFObject?] = []
    var totalMessages: NSInteger = 0
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(SettingsViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.separatorStyle = .none
        tableView.scrollsToTop = true
        checkForNewMessages()
        tableView.reloadData()
        Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.checkForNewMessages), userInfo: nil, repeats: true)
        
        roundButtons()
        // Do any additional setup after loading the view.
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        checkForNewMessages()
        tableView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    func fetchMessage() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.limit = 10
        query.includeKeys(["user", "createdAt"])
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }
    
    func loadMoreMessages(alreadyLoaded: NSInteger) {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.limit = 10
        query.skip = messages.count
        query.includeKeys(["user", "createdAt"])
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                for message in messages {
                    self.messages.append(message)
                }
                self.tableView.reloadData()
            } else {
                print(error!.localizedDescription)
            }
        }
    }

    
    @objc func checkForNewMessages() {
        let query = PFQuery(className: "Message")
        query.countObjectsInBackground { (count, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                let foundMessages = NSInteger(count.description)!
                if foundMessages > self.totalMessages {
                    self.totalMessages = foundMessages
                    self.fetchMessage()
                }
            }
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error != nil) {
                print(error.debugDescription)
                print(error!.localizedDescription)
            }
        }
            UserDefaults.standard.set(false, forKey: "userLoggedIn")
            self.performSegue(withIdentifier: "logoutSegue", sender: nil)
    }
    
    func roundButtons() {
        logoutButton.layer.cornerRadius = 20
        sendButton.layer.cornerRadius = 20
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.message = messages[indexPath.row]
        cell.selectionStyle = .none
        print("Message #\(indexPath.row+1) loaded")
        if indexPath.row == messages.count - 1 {
            if totalMessages > messages.count {
                loadMoreMessages(alreadyLoaded: messages.count)
            }
        }
        
        return cell
    }
    
    @IBAction func onSend(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.messageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
