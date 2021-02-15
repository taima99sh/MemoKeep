//
//  LoginVewController.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseAuth
import SVProgressHUD
import MagicalRecord

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnForgetPassword: UIButton!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    @IBOutlet weak var btnToRigester: UIButton!
    
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
    
    @IBAction func btnLogin(_ sender: Any) {
        
        //guard self.validation() else {return}
        let email =  txtEmail.text ?? ""
        let password = txtPassword.text ?? ""
        showLoader(true)
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            self?.showLoader(false)
            if let error = error {
                self?.ErrorMessage(title: "", errorbody: error.localizedDescription)
                return
            }
            if let authResult = authResult {
                UserProfile.shared.userID = authResult.user.uid
                let user = TUser.mr_createEntity()
                user?.id = UserProfile.shared.userID ?? ""
                NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
            }
        }
    }
    
    
    @IBAction func btnToRigester(_ sender: Any) {
        
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func btnForgetPassword(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension LoginViewController {
    func setupView(){}
    func localized(){}
    func setupData(){}
    func fetchData(){}
}

extension LoginViewController {
    func validation() -> Bool {
        if !(txtEmail.isValidValue && txtPassword.isValidValue && Emailvalidation()) == false {
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
}
