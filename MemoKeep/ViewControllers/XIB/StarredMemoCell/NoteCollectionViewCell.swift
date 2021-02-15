//
//  NoteCollectionViewCell.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

var colorItems: [Constant.MemoColor] = [.red,.black, .white, .purple, .blue ]

class NoteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    
    var object: Memo?
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell() {
        if let obj = object {
            self.colorView.backgroundColor = colorItems[obj.color].color
            self.lblTitle.text = obj.title
            self.lblBody.text = obj.body ?? ""
        }
    }
    
}
