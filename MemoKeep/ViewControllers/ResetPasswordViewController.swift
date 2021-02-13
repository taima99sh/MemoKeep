//
//  ResetPassword.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseAuth

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    var email: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func btnSend(_ sender: Any) {
        guard validation() else {return}
        let code = txtCode.text ?? ""
        let password = txtPassword.text ?? ""
        Auth.auth().confirmPasswordReset(withCode: code, newPassword: password) { (error) in
            if let error = error {
                self.ErrorMessage(title: "", errorbody: error.localizedDescription)
                return
            }
            print ("success")
        }
        return
        Auth.auth().verifyPasswordResetCode(code) { (result, error) in
            if let error = error {
                self.ErrorMessage(title: "", errorbody: error.localizedDescription)
                return
            }
            print(result)
        }
    }
}
extension ResetPasswordViewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}

extension ResetPasswordViewController {
    func validation() -> Bool {
        if (txtConfirmPassword.isValidValue && txtPassword.isValidValue && passwordValidation() ) == false {
            self.ErrorMessage(title: "", errorbody: "There are empty fields")
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
