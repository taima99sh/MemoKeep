//
//  MemoBooksViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import Firebase
import Firebase
import MagicalRecord

class MemoBooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBookMemoStackView: UIStackView!
    @IBOutlet weak var txtNewMemoBook: UITextField!
    var localMemoBook: [TMemoBook] = []

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
    
    @IBAction func btnNewMemoBook(_ sender: Any) {
        self.addBookMemoStackView.isHidden = false
    }
    
    @IBAction func btnDone(_ sender: Any) {
        guard txtNewMemoBook.isValidValue else {return}
        saveInCoreDate()
        let title = txtNewMemoBook.text ?? ""
        let memoBook = MemoBook(id: nil, title: title, date: Date(), memos: nil)
        let db = Firestore.firestore()
         let userRef = db.collection("users").document(UserProfile.shared.userID ?? "")
         let memoBooksRef = userRef.collection("MemoBooks")
        
        do {
            try memoBooksRef.addDocument(from: memoBook)
        } catch let error {
            print("Error writing user to Firestore: \(error.localizedDescription)")
        }
        
        self.addBookMemoStackView.isHidden = true
        self.fetchData()
    }
}

extension MemoBooksViewController {
    func setupView(){
        tableView.register(UINib(nibName: "MemoBookTableViewCell", bundle: nil), forCellReuseIdentifier: "MemoBookTableViewCell")
        addBookMemoStackView.isHidden = true
    }
    func localized(){}
    func setupData(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchData(){
    }
    
    func saveInCoreDate() {
        let memoBook = TMemoBook.mr_createEntity()
        memoBook?.id = UUID().uuidString
        memoBook?.date = Date()
        memoBook?.title = self.txtNewMemoBook.text ?? ""
        memoBook?.userId = UserProfile.shared.userID
        memoBook?.ofUser = TUser.mr_findFirst(byAttribute: "id", withValue: UserProfile.shared.userID ?? "") ?? TUser()
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        print("j")
    }
    
    func getDataFromCoreData() -> [TMemoBook] {
        let arr = TMemoBook.mr_findAll() as! [TMemoBook]
        print (arr)
        return arr
    }
}

extension MemoBooksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Reachability.isConnectedToNetwork() ? Constant.shared.memoBooks.count : localMemoBook.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoBookTableViewCell", for: indexPath) as! MemoBookTableViewCell
        cell.object = Constant.shared.memoBooks[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "MemosListViewController") as! MemosListViewController
        vc.MemoBookId = Constant.shared.memoBooks[indexPath.row].id ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
}

