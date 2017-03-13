//
//  LoginViewController.swift
//  Instagram
//
//  Created by Thuan Nguyen on 3/7/17.
//  Copyright © 2017 Thuan Nguyen. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var userPasswordField: UITextField!
    @IBOutlet weak var userNameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = userNameField.text
        newUser.password = userPasswordField.text
        newUser.signUpInBackground { (success: Bool, error: Error?) in
            if success {
                print("signed up")
                self.performSegue(withIdentifier: "logInSeque", sender: Any.self)
            }
            else {
            print(error?.localizedDescription ?? "error")
            }
        }
        
    }
    @IBAction func logIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userNameField.text!, password: userPasswordField.text!) { (user: PFUser?, error: Error?) in
            if user != nil {
                print(user)
                self.performSegue(withIdentifier: "logInSeque", sender: Any.self)

            }
            else{
            print(error?.localizedDescription)
            }
            
        }
        
        
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
