//
//  ViewController.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class ViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        createUser()
    }
    
    @IBAction func btnForgetPassword(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController {
        func createUser() {
            let email = txtEmail.text ?? ""
            let password = txtPassword.text ?? ""
            SVProgressHUD.show()
            Auth.auth().createUser(withEmail: email, password: password) { (data, error) in
                SVProgressHUD.dismiss()
                if let error = error {
                    self.ErrorMessage(title: "", errorbody: error.localizedDescription)
                    return
                }
                self.SuccessMessage(title: "", successbody: "you have signed up successfully")
            }
    }
}

extension ViewController {
    func validation() -> Bool {
        if (txtEmail.isValidValue && txtPassword.isValidValue && Emailvalidation() && passwordValidation()) == false {
            self.ErrorMessage(title: "", errorbody: "There are empty fields")
            return false
        }
        return true
    }
    
    func Emailvalidation() -> Bool {
        if !(txtEmail.text?.isValidEmail()  ?? true) {
            self.ErrorMessage(title: "", errorbody: "This email is baddly formatted")
            return false
        }
        return true
    }
    
    func passwordValidation() -> Bool {
        if !(txtConfirmPassword.text ?? "" == txtPassword.text ?? "") {
            self.ErrorMessage(title: "", errorbody: "Passwords do not matched")
            return false
        }
        return true
    }
}

