//
//  ViewController.swift
//  loginScreen
//
//  Created by Andrew Emory on 12/4/18.
//  Copyright © 2018 Andrew Emory. All rights reserved.
//

import UIKit
import  FirebaseAuth

//login info for testing:
    //acemory@wustl.edu
    //abcd1234

class ViewController: UIViewController {
    
    //LOCAL VAR FOR BUTTON STATE
    var is_form_valid = false
    
    //PREVENT SCREEN ROTATION
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
//IB-OUTLETS
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var password_text_field: UITextField!
    @IBOutlet weak var login_btn: UIButton!
    
    
//IB-ACTIONS
    //FORGOT PASSWORD
    @IBAction func forgot_password_btn_pressed(_ sender: Any) {
        let emailTextField = UITextField(frame: CGRect(x: 0, y: 0, width: 150, height: 80))
        
        let resetAlert = UIAlertController(title: "Reset Password", message: "Enter email", preferredStyle: .alert)
        resetAlert.addTextField(configurationHandler: { (emailTextField) in
            emailTextField.placeholder = "Enter email"
        })
        
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { (action) in
            if let email = resetAlert.textFields![0].text {
                Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                    if let error = error{
                        let errorAlert = UIAlertController(title: "Error sending reset email", message: "", preferredStyle: .alert)
                        let errorDoneAction = UIAlertAction(title: "Done", style: .default) { (action) in}
                        errorAlert.addAction(errorDoneAction)
                        self.present(errorAlert, animated: true)
                    }
                    else{
                        let successAlert = UIAlertController(title: "Sent reset password email", message: "", preferredStyle: .alert)
                        let sentDoneAction = UIAlertAction(title: "Done", style: .default) { (action) in}
                        successAlert.addAction(sentDoneAction)
                        self.present(successAlert, animated: true)
                    }
                }
                
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in}
        
        resetAlert.addAction(doneAction)
        resetAlert.addAction(cancelAction)
        print("present reset alert")
        self.present(resetAlert, animated: true)
    }
    
    //LOGIN
    @IBAction func login_btn_pressed(_ sender: Any) {
        //LOGIN CALL TO FIREBASE
        Auth.auth().signIn(withEmail: email_text_field.text!, password: password_text_field.text!) { (user, error) in
            //SUCCESSFUL LOGIN
            if let u = user {
                self.segue_to_home()
            } else {
                let alert = UIAlertController(title: "Sign In Failed",
                                              message: error!.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //SIGN UP SEGUE
    @IBAction func sign_up_btn_pressed(_ sender: Any) {
        performSegue(withIdentifier: "sign_up_segue", sender: self)
    }
    
    //PASSWORD EDITING
    @IBAction func pswd_editing_changed(_ sender: UITextField) {
        check_form_validity()
        change_login_btn_state(b: is_form_valid)
    }
    
    //EMAIL EDITING
    @IBAction func email_editing_changed(_ sender: UITextField) {
        check_form_validity()
        change_login_btn_state(b: is_form_valid)
    }
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ROUNDING LOGIN BUTTON CORNERS A BIT
        login_btn.layer.cornerRadius = 5
        
        //CHECK FORM VALIDITY AND BUTTON STATE
        check_form_validity()
        change_login_btn_state(b: is_form_valid)

    }
    
    //CHECK FORM VALIDITY
    func check_form_validity(){
        if (email_text_field.text?.range(of: "@") != nil && (password_text_field.text?.count)! > 2){
            is_form_valid = true
        } else {
            is_form_valid = false
        }
    }

    //CHANGE BTN STATE
    func change_login_btn_state(b: Bool){
        if(b){
            login_btn.isEnabled = true
            login_btn.alpha = 1
        } else {
            login_btn.isEnabled = false
            login_btn.alpha = 0.35
        }
    }
    
    //SEGUE TO HOME SCREEN
    func segue_to_home(){
        performSegue(withIdentifier: "login_to_home", sender: self)
    }
    

}

