//
//  MemoBooksViewController.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MemoBooksViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

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
    }
    
}
extension MemoBooksViewController {
    func setupView(){
        tableView.register(UINib(nibName: "MemoBookTableViewCell", bundle: nil), forCellReuseIdentifier: "MemoBookTableViewCell")
    }
    func localized(){}
    func setupData(){}
    func fetchData(){
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MemoBooksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoBookTableViewCell", for: indexPath) as! MemoBookTableViewCell
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
    
    
    
}

