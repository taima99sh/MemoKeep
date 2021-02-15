//
//  FirstViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestoreSwift

class FirstViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    var vc1: MemosViewController!
    var vc2: MemoBooksViewController!
    var vc1Active : Bool = false
    
    
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
    
    @IBAction func btnAddMemo(_ sender: Any) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AddMemoViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnMemosTab(_ sender: Any) {
         if !vc1Active  {
            for sView in self.containerView.subviews {
                sView.removeFromSuperview()
            }
            vc1Active = true
            vc1.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc1.view)
        }
    }
    
    @IBAction func btnMemoBooks(_ sender: Any) {
        if vc1Active == true {
            for sView in self.containerView.subviews {
                sView.removeFromSuperview()
            }
        vc1Active = false
        vc2.view.frame = self.containerView.bounds
            self.containerView.addSubview(vc2.view)
            
        }
    }
}
    

extension FirstViewController {
    func setupView(){}
    func localized(){}
    func setupData(){
        vc1 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MemosViewController") as! MemosViewController
        vc2 = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MemoBooksViewController") as! MemoBooksViewController
        
        self.addChild(vc1)
        self.addChild(vc2)
        vc1.view.frame = self.containerView.bounds
        self.containerView.addSubview(vc1.view)
        vc1Active = true
    }
    func fetchData(){
        let db = Firestore.firestore()
         let userRef = db.collection("users").document(UserProfile.shared.userID ?? "")
         let memoBooksRef = userRef.collection("MemoBooks")
         memoBooksRef.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let querySnapshot = querySnapshot {
                Constant.shared.memoBooks.removeAll()
                for doc in querySnapshot.documents {
                    ///
                    let result = Result {
                        try doc.data(as: MemoBook.self)
                    }
                    switch result {
                    case .success(var memoBook):
                        memoBook?.id = doc.documentID
                        if let memoBook = memoBook {
                            Constant.shared.memoBooks.append(memoBook)
                            print("\(memoBook.title)")
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding memoBook: \(error)")
                    }
                }
            }
        }
    }
    func getStarredMemos(){
    }
}
