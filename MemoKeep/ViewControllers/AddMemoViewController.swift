//
//  AddMemoViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class AddMemoViewController: UIViewController {
    
    @IBOutlet weak var imgBook: UIImageView!
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var txtBody: UITextView!
    @IBOutlet weak var collectionView: UICollectionView!

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
    
    @IBAction func btnChooseColor(_ sender: Any) {}
    
    @IBAction func btnStar(_ sender: Any) {}
    
    @IBAction func btnToRigester(_ sender: Any) {}
    
    @IBAction func btnChooseMemoBook(_ sender: Any) {}
    
}
extension AddMemoViewController {
    func setupView(){
        self.collectionView.isHidden = true
    }
    func localized(){}
    func setupData(){
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    func fetchData() {}
}

extension AddMemoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemoColorCollectionViewCell", for: indexPath) as! MemoColorCollectionViewCell
        return cell
    }
}


extension AddMemoViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize.init(width: 50, height: 50)
    }
}
