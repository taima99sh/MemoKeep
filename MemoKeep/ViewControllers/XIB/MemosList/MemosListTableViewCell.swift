//
//  MemosListTableViewCell.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import UIKit

class MemosListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    
    var object: Memo?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell() {
        if let obj = self.object {
            lblTitle.text = obj.title
            lblBody.text = obj.body ?? ""
            lblDate.text = obj.date.toString(customFormat: "MMM d, yyyy")
        }
    }
    
}
