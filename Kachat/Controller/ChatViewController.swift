//
//  ChatViewController.swift
//  Kachat
//
//  Created by Gino Tasis on 3/8/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // creating reference to our database
    let db = Firestore.firestore()
    
    var messageData = MessageData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "Person"
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        
        loadMessages()
    }
    
    
    func loadMessages() {
        
        db.collection("messages")
            .order(by: "date")
            .addSnapshotListener { (querySnapshot, err) in
            
            self.messageData.messages = []
            
            if let err = err {
                print("Error getting messages: \(err)")
            } else {
                if let snapShotDocuments = querySnapshot?.documents {
                    
                    for doc in snapShotDocuments {
                        let data = doc.data()
                        if let sender = data["sender"] as? String, let messageBody = data["body"] as? String {
                            let newMessage = Message(sender: sender, body: messageBody)
                            self.messageData.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                // when the page loads, we scroll all the way down to the bottom
                                let indexPath = IndexPath(row: self.messageData.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
   
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection("messages").addDocument(
                data: ["sender": messageSender,
                       "body": messageBody,
                       "date": Date().timeIntervalSince1970
                      ]) { error in
                if let er = error {
                    print(er.localizedDescription)
                } else {
                    print("Succesfully saved data")
                    self.messageTextField.text = ""
                }
            }
        }
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
           
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
        
    }
    
}

extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageData.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messageData.messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath ) as! MessageTableViewCell
        
        cell.label.text = message.body
        
        
        // this is a message from the current user
        if message.sender == Auth.auth().currentUser?.email {
                
            cell.leftImageView.isHidden = true
            cell.imageView?.isHidden = false
            cell.messageBubble.backgroundColor = .purple
            cell.label.textColor = .white
            
        } else {
            // message from another sender
            cell.leftImageView.isHidden = false
            cell.imageView?.isHidden = true
            cell.messageBubble.backgroundColor = .cyan
            cell.label.textColor = .black
        }
       
        return cell
    }
    
}
