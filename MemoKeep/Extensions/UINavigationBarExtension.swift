//
//  UINavigationBarExtension.swift
//  Yahia Gallery
//
//  Created by taima on 11/25/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit


extension UINavigationItem {
    @IBInspectable var  doesHaveBackTitle: Bool{
         set {
            self.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         }
         get{
             return false
         }
     }
    
    @IBInspectable var imageTitle: UIImage? {
        set {
            let imageView = UIImageView(image: newValue)
            imageView.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
            imageView.contentMode = .scaleAspectFit
            self.titleView = imageView
        }
        get {
//            return nil
            return self.imageTitle
        }
    }
}

extension UINavigationBar {
    @IBInspectable var  haveShadow: Bool{
         set {
            self.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
            self.shadowImage = UIImage()
            self.isTranslucent = true
                
         }
         get{
             return false
         }
                
     }
    

    
//    @IBInspectable
//    var imageForSelected: UIImage? {
//        get {
//            return image(for: .selected)
//        }
//        set {
//            setImage(newValue, for: .selected)
//        }
//    }
    
}
