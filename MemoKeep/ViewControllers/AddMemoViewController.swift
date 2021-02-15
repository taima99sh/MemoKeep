//
//  AddMemoViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit
import DropDown
import FirebaseFirestoreSwift
import Firebase
import MagicalRecord

class AddMemoViewController: UIViewController {
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var btnChooseColor: UIButton!
    @IBOutlet weak var btnChooseMemoBook: UIButton!
    @IBOutlet weak var btnStar: UIButton!
    
    var memo: Memo?
    var memoBookId: String = ""
    var color: Int = 0
    
    
    
        var arrType = ["القدس"
    , "بيت لحم", "رام الله", "غزة"]

    let chooseDropDown = DropDown()
    
    var btnColorIsSelected: Bool = false {
        didSet {
            self.collectionView.isHidden = !btnColorIsSelected
        }
    }
    
    var isStarred: Bool = false {
        didSet {
            if isStarred {
                self.btnStar.setImage(UIImage(systemName: "star.fill"), for: .normal)
                self.btnStar.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
                return
            }
            self.btnStar.setImage(UIImage(systemName: "star"), for: .normal)
            self.btnStar.tintColor = "placeholder".myColor
        }
    }

    var localMemosBook: [TMemoBook] = []
    //var colorItems: [Constant.MemoColor] = [.black, .blue, .purple, .red, .white]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
        //fetchData()
        getDataFromCoreData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func btnChooseColor(_ sender: Any) {
        btnColorIsSelected = !btnColorIsSelected
    }
    
    @IBAction func btnStar(_ sender: Any) {
        self.isStarred = !isStarred
    }
    
    @IBAction func btnToRigester(_ sender: Any) {}
    
    @IBAction func btnChooseMemoBook(_ sender: Any) {
        chooseDropDown.show()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if !Reachability.isConnectedToNetwork(){
            saveInCoreDate()
            return
        }
        let db = Firestore.firestore()
         let userRef = db.collection("users").document(UserProfile.shared.userID ?? "")
         let memoBooksRef = userRef.collection("MemoBooks")
        let title = self.txtTitle.text ?? ""
        let body = self.txtBody.text ?? ""
        let date = Date()
        let newMemo: Memo = Memo(title: title, body: body, date: date, isStarred: self.isStarred, color: color)
        if let memo = self.memo {
            let ref = memoBooksRef.document(self.memoBookId).collection("memos").document(memo.id ?? "")
            do {
                try ref.setData(from: newMemo)
                print("j")
            } catch let error {
                print("Error writing memo to Firestore: \(error)")
            }
            return
        }
        let ref = memoBooksRef.document(self.memoBookId).collection("memos")
        do {
            try ref.addDocument(from: newMemo)
            print("j")
        } catch let error {
            print("Error writing memo to Firestore: \(error)")
        }
    }
    
    func setupChooseDropDown() {
        chooseDropDown.anchorView = btnChooseMemoBook
        chooseDropDown.bottomOffset = CGPoint(x: 0, y: btnChooseMemoBook.bounds.height)
        chooseDropDown.textFont = Constant.shared.ProjectFont.toFont() ?? UIFont(name: "Arial", size: 14)!
        
         if Reachability.isConnectedToNetwork(){
             chooseDropDown.dataSource = Constant.shared.memoBooks.map { $0.title }
        }else{
            chooseDropDown.dataSource = getDataFromCoreData().map { $0.title }
        }
       
        // Action triggered on selection
        chooseDropDown.selectionAction = { [weak self] (index, item) in
            self?.btnChooseMemoBook.setTitle(item, for: .normal)
            
            self?.memoBookId = Reachability.isConnectedToNetwork() ? Constant.shared.memoBooks[index].id ?? "" : self?.localMemosBook[index].id ?? ""
            print("")
        }
    }
}
extension AddMemoViewController {
    func setupView(){
        self.collectionView.isHidden = true
        btnChooseColor.imageView?.setImageColor(color: "placeholder".myColor)
    }
    func localized(){}
    func setupData(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setupChooseDropDown()
    }
    
    func fetchData() {
        if let memo = self.memo {
            self.txtTitle.text = memo.title
            self.txtBody.text = memo.body ?? ""
            self.isStarred = memo.isStarred ?? false
            self.btnChooseMemoBook.isEnabled = false
            if let item = Constant.shared.memoBooks.first(where: {$0.id == self.memoBookId}) {
                self.btnChooseMemoBook.setTitle(item.title, for: .normal)
            }
            let index = colorItems.firstIndex{$0.colorName == memo.color}
            self.colorView.backgroundColor = colorItems[index ?? 0].color
        }
    }
    func getDataFromCoreData() -> [TMemoBook] {
        let arr = TMemoBook.mr_findAll() as! [TMemoBook]
        print (arr)
        self.localMemosBook = arr
        return arr
    }
    func saveInCoreDate() {
        let memo = TMemo.mr_createEntity()
        memo?.id = UUID()
        memo?.date = Date()
        memo?.title = self.txtTitle.text ?? ""
        memo?.body = self.txtBody.text
        memo?.memoBook = TMemoBook.mr_findFirst(byAttribute: "id", withValue: self.memoBookId) ?? TMemoBook()
       // memoBook.
        NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        print("j")
    }
    
    func updateDataCoreDate() {
   //to do
    }
    
}

extension AddMemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colorItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoColorCollectionViewCell", for: indexPath) as! MemoColorCollectionViewCell
        cell.object = colorItems[indexPath.row]
        cell.configureCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoColorCollectionViewCell", for: indexPath) as! MemoColorCollectionViewCell
        cell.isSelectedColor = true
        btnChooseColor.imageView?.setImageColor(color: colorItems[indexPath.row].color)
        self.color = colorItems[indexPath.row].colorName
        self.colorView.backgroundColor = colorItems[indexPath.row].color
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoColorCollectionViewCell", for: indexPath) as! MemoColorCollectionViewCell
        cell.isSelectedColor = false
    }
}


extension AddMemoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize.init(width: 50, height: 50)
    }
}
