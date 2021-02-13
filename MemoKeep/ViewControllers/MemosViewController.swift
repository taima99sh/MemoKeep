//
//  MemosViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MemosViewController: UIViewController {
    
    @IBOutlet weak var starredCollectionView: UICollectionView!
    
    @IBOutlet weak var memosTableView: UITableView!
    
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
    func fetchData(){}
}

extension MemosViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddNewNoteCollectionViewCell", for: indexPath) as! AddNewNoteCollectionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NoteCollectionViewCell", for: indexPath) as! NoteCollectionViewCell
        return cell
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
}

