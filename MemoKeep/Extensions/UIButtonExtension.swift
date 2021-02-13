//
//  UIButtonExtension.swift
//  Yahia Gallery
//
//  Created by taima on 12/16/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable var imageTinitColor: UIColor {
        set {
            let img = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.setImage(img, for: .normal)
            self.tintColor = newValue
        } get {
            return self.tintColor
        }
    }
    
    @IBInspectable var fontType: String {
        set {
            switch newValue {
            case "body":
                self.titleLabel?.font = Constant.shared.ProjectFont.toFont(size: 16) ?? UIFont(name: "Arial", size: 14)
            case "h1":
                self.titleLabel?.font = Constant.shared.ProjectFont.toFont(size: 22) ?? UIFont(name: "Arial", size: 14)
            case "h2":
                self.titleLabel?.font = Constant.shared.ProjectFont.toFont(size: 16) ?? UIFont(name: "Arial", size: 14)
            default:
                self.titleLabel?.font = Constant.shared.ProjectFont.toFont(size: 16) ??  UIFont(name: "Arial", size: 14)
            }
        }
        get {
            return self.fontType
        }
    }
}
