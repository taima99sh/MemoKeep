//
//  MemosViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import FirebaseFirestoreSwift
import Firebase
class MemosViewController: UIViewController {
    
    @IBOutlet weak var starredCollectionView: UICollectionView!
    
    @IBOutlet weak var memosTableView: UITableView!
    
    var starredMemos: [Memo] = []
    
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
        getStarredMemos()
    }
}
extension MemosViewController {
    func setupView(){
        starredCollectionView.register(UINib(nibName: "AddNewNoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddNewNoteCollectionViewCell")
        
        starredCollectionView.register(UINib(nibName: "NoteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NoteCollectionViewCell")
        
        memosTableView.register(UINib(nibName: "MemosListTableViewCell", bundle: nil), forCellReuseIdentifier: "MemosListTableViewCell")

    }
    func localized(){}
    func setupData(){
        starredCollectionView.delegate = self
        starredCollectionView.dataSource = self
        memosTableView.delegate = self
        memosTableView.dataSource = self
    }
    func fetchData(){
    }
    
    func getStarredMemos() {
        for memoBook in Constant.shared.memoBooks {
            getMemos(memoBook.id ?? "")
        }
    }
    
    func getStarredMemosFromCoreData() -> [TMemo] {
        let arr = TMemo.mr_find(byAttribute: "isStarred", withValue: true) as! [TMemo]
        return arr
    }
}


extension MemosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.starredMemos.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNewNoteCollectionViewCell", for: indexPath) as! AddNewNoteCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCollectionViewCell", for: indexPath) as! NoteCollectionViewCell
        cell.object = self.starredMemos[indexPath.row - 1]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.mainStoryboard.instantiateViewController(withIdentifier: "AddMemoViewController") as! AddMemoViewController
        if indexPath.row == 0 {
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        vc.memo = self.starredMemos[indexPath.row - 1]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension MemosViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //let height: CGFloat = 165
        let width: CGFloat = (UIScreen.main.bounds.size.width - ( 30 + 30)) / 2
            return CGSize.init(width: 170, height: 180)
    }
}

extension MemosViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemosListTableViewCell", for: indexPath) as! MemosListTableViewCell
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
     func getMemos(_ memoBookID: String) {
        let db = Firestore.firestore()
         let userRef = db.collection("users").document(UserProfile.shared.userID ?? "")
         let memoBooksRef = userRef.collection("MemoBooks")
         let ref = memoBooksRef.document(memoBookID).collection("memos")
        ref.whereField("isStarred", isEqualTo: true).getDocuments { (querySnapshot, error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
            
                if let querySnapshot = querySnapshot {
                   self.starredMemos.removeAll()
                    for doc in querySnapshot.documents {
                        ///
                        let result = Result {
                            try doc.data(as: Memo.self)
                        }
                        switch result {
                        case .success(var memo):
                            memo?.id = doc.documentID
                            if let memo = memo {
                                self.starredMemos.append(memo)
                                print("\(memo.title)")
                            } else {
                                print("Document does not exist")
                            }
                        case .failure(let error):
                            print("Error decoding memoBook: \(error)")
                        }
                    }
                    
                print("")
                    self.starredCollectionView.reloadData()
                }
            }
        }
    }


