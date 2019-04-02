//
//  SignUp_VC.swift
//  loginScreen
//
//  Created by Andrew Emory on 12/8/18.
//  Copyright © 2018 Andrew Emory. All rights reserved.
//

import UIKit
import Firebase

class SignUp_VC: UIViewController {
    
    //LOCAL VAR FOR BUTTON STATE
    var is_form_valid = false
    
    //PREVENT SCREEN ROTATION
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        get {
            return .portrait
        }
    }
    
//IB-OUTLETS
    @IBOutlet weak var signup_btn: UIButton!
    @IBOutlet weak var email_text_field: UITextField!
    @IBOutlet weak var pswd1_text_field: UITextField!
    @IBOutlet weak var pswd2_text_field: UITextField!
    

//IB-ACTIONS
    //LOGIN SEGUE
    @IBAction func login_segue_btn_pressed(_ sender: Any) {
        performSegue(withIdentifier: "login_segue", sender: self)
    }
    
    //SIGN UP
    @IBAction func signUp_btn_pressed(_ sender: Any) {
        //SIGNUP CALL TO FIREBASE
        Auth.auth().createUser(withEmail: email_text_field.text!, password: pswd2_text_field.text!) { (user, error) in
            if let u = user {
                self.segue_to_home()
            } else {
                let alert = UIAlertController(title: "Sign Up Failed",
                                              message: error!.localizedDescription,
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
    //EMAIL EDITING
    @IBAction func email_editing_changed(_ sender: UITextField) {
        check_form_validity()
        change_signup_btn_state(b: is_form_valid)
    }
    
    //PASSWORD_1 EDITING
    @IBAction func pswd1_editing_changed(_ sender: UITextField) {
        check_form_validity()
        change_signup_btn_state(b: is_form_valid)
    }
    
    //PASSWORD_2 EDITING
    @IBAction func pswd2_editing_changed(_ sender: UITextField) {
        check_form_validity()
        change_signup_btn_state(b: is_form_valid)
    }
    

    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ROUND SIGN UP BUTTON CORNERS A BIT
        signup_btn.layer.cornerRadius = 5
        
        //CHECK FORM VALIDITY AND BUTTON STATE
        check_form_validity()
        change_signup_btn_state(b: is_form_valid)
    }
    
    //CHECK FORM VALIDITY
    func check_form_validity(){
        if (email_text_field.text?.range(of: "@") != nil && (pswd1_text_field.text?.count)! > 2 && pswd1_text_field.text == pswd2_text_field.text){
            is_form_valid = true
        } else {
            is_form_valid = false
        }
    }
    
    //CHANGE BTN STATE
    func change_signup_btn_state(b: Bool){
        if(b){
            signup_btn.isEnabled = true
            signup_btn.alpha = 1
        } else {
            signup_btn.isEnabled = false
            signup_btn.alpha = 0.35
        }
    }
    
    //SEGUE TO HOME SCREEN
    func segue_to_home(){
        performSegue(withIdentifier: "signUp_to_home", sender: self)
    }
    

}
