//
//  MainViewController.swift
//  FirstClass
//
//  Created by Pedro Delmonte on 22/05/17.
//  Copyright © 2017 BTS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var users = [String]()
    var db = DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        db = Database.database().reference()
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        defer {
            dismiss(animated: true, completion: nil)
        }
        do {
            try Auth.auth().signOut()
        } catch {
            print("error: can not log out")
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! UserTableViewCell
        cell.nameLabel.text = users[indexPath.row]
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
