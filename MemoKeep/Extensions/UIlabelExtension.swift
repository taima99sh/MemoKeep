//
//  UIlabelExtension.swift
//  Hyakah
//
//  Created by taima on 11/6/20.
//  Copyright © 2020 mac air. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
extension UILabel {

    @IBInspectable var fontType: String {
        set {
            switch newValue {
            case "body":
                self.font = Constant.shared.ProjectFont.toFont(size: 17) ?? UIFont(name: "Arial", size: 14)
            case "bold":
                self.font = UIFont(name: "Helvetica Neue W23 for SKY-Bold", size: 17) ?? UIFont(name: "Arial", size: 14)
            case "h2":
                self.font = Constant.shared.ProjectFont.toFont(size: 20) ?? UIFont(name: "Arial", size: 14)
            default:
                self.font = Constant.shared.ProjectFont.toFont(size: 16) ??  UIFont(name: "Arial", size: 14)
            }
        }
        get {
            return self.fontType
        }
    }
}
