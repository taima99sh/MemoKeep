//
//  MemosListViewController.swift
//  MemoKeep
//
//  Created by taima on 2/14/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import Firebase
import MagicalRecord
class MemosListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableArr: [Memo] = []
    var MemoBookId: String = ""

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
}
extension MemosListViewController {
    func setupView(){
        tableView.register(UINib(nibName: "MemosListTableViewCell", bundle: nil), forCellReuseIdentifier: "MemosListTableViewCell")
    }
    func localized(){}
    func setupData(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    func fetchData(){
         let db = Firestore.firestore()
         let userRef = db.collection("users").document(UserProfile.shared.userID ?? "")
         let memoBooksRef = userRef.collection("MemoBooks")
       let ref = memoBooksRef.document(self.MemoBookId).collection("memos")
        ref.getDocuments { (querySnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let querySnapshot = querySnapshot {
                self.tableArr.removeAll()
                for doc in querySnapshot.documents {
                    ///
                    let result = Result {
                        try doc.data(as: Memo.self)
                    }
                    switch result {
                    case .success(var memo):
                        memo?.id = doc.documentID
                        if let memo = memo {
                            self.tableArr.append(memo)
                            print("\(memo.title)")
                        } else {
                            print("Document does not exist")
                        }
                    case .failure(let error):
                        print("Error decoding memoBook: \(error)")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func getAllMemosFromCoreData() -> [TMemo] {
        let arr = TMemo.mr_findAll() as! [TMemo]
        return arr
    }
    
    func getMemosFromCoreData()-> [TMemo] {
        let arr = TMemo.mr_find(byAttribute: "memoBookId", withValue: self.MemoBookId) as! [TMemo]
        return arr
    }
}


extension MemosListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.tableArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemosListTableViewCell", for: indexPath) as! MemosListTableViewCell
        cell.object = tableArr[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AddMemoViewController") as! AddMemoViewController
        vc.memo = tableArr[indexPath.row]
        vc.memoBookId = self.MemoBookId
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
