//
//  ViewController.swift
//  FirstClass
//
//  Created by Pedro Delmonte on 11/05/17.
//  Copyright © 2017 BTS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailtextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    var db: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helloLabel.text = "Hello from Code"
        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        db = Database.database().reference()
        
        if let name = UserDefaults.standard.object(forKey: "UserName") as? String {
            nameTextField.text = name
        }
        
        if let user = Auth.auth().currentUser {
            performSegue(withIdentifier: "RegisterToMain", sender: nil)
        }
        
    }

       override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registrationButtonPressed(_ sender: UIButton) {
        if let email = emailtextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = self.fullNameTextField.text ?? ""
                changeRequest.commitChanges(completion: nil)
                let userInfo = ["uid": user.uid,
                                "name": self.fullNameTextField.text ?? "",
                                "age": self.ageTextField.text ?? ""
                                ]
                self.db.child("users").child(user.uid).setValue(userInfo)
                print("user: \(user)")
                self.performSegue(withIdentifier: "RegisterToMain", sender: nil)
                self.showMessage(message: "User Created!")
            } else {
                self.showMessage(message: "Something went wrong")
                print("error: \(error)")
            }
            }
        }
    }
    
    func showMessage(message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func greetMeButtonPressed(_ sender: Any) {
        updateHelloMessage()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        updateHelloMessage()
        return true
    }
    
    func updateHelloMessage() {
        if let text = nameTextField.text, !text.characters.isEmpty {
            UserDefaults.standard.set(text, forKey: "UserName")
            helloLabel.text = "Hello, " + text
        } else {
            UserDefaults.standard.removeObject(forKey: "UserName")
            helloLabel.text = "Hello, stranger"
        }
        UserDefaults.standard.synchronize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToModalViewController" {
            if let dest = segue.destination as? ModalViewController{
                dest.name = nameTextField.text
            }
        }
    }
    
}

