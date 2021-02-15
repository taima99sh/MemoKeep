//
//  MainNavigationController.swift
//  MemoKeep
//
//  Created by taima on 2/14/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

  }
extension MainNavigationViewController {
    
    func setupView() {
        AppDelegate.shared.rootNavigationViewController = self
        if UserProfile.shared.isUserLogin() {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "FirstViewController")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
        }else {
            let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController")
            AppDelegate.shared.rootNavigationViewController.setViewControllers([vc], animated: true)
        }
    }
    
    func localized() {
    }
    
    func setupData() {
    }
    
    func fetchData() {
    }
}
