//
//  ForgetPasswordViewController.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSend(_ sender: Any) {
        guard self.validation() else {return}
        let email = txtEmail.text ?? ""
        SVProgressHUD.show()
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            SVProgressHUD.dismiss()
            if let error = error {
                self.ErrorMessage(title: "", errorbody: error.localizedDescription)
                return
            }
            self.SuccessMessage(title: "", successbody: "A link sent to your email to reset your password")
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
}
extension ForgetPasswordViewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}

extension ForgetPasswordViewController {
    func validation() -> Bool {
        if (txtEmail.isValidValue && Emailvalidation()) == false {
            self.ErrorMessage(title: "", errorbody: "Please enter your Email")
            return false
        }
        return true
    }
    
    func Emailvalidation() -> Bool {
        if !(txtEmail.text?.isValidEmail()  ?? true) {
            self.ErrorMessage(title: "", errorbody: "This Email is baddly formatted")
            return false
        }
        return true
    }
}

