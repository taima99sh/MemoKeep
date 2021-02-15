//
//  MemoColorCollectionViewCell.swift
//  MemoKeep
//
//  Created by taima on 2/11/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MemoColorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var colorView: UIView!
    
    var object: Constant.MemoColor?
    
    var isSelectedColor: Bool = false {
        didSet {
            if isSelected {
                self.colorView.borderWidth = 1
                self.colorView.borderColor = "placeholder".myColor
            }else {
                self.colorView.borderWidth = 0
            }
        }
    }
    
    func configureCell() {
        if let obj = self.object {
            self.colorView.backgroundColor = obj.color
        }
    }
}
