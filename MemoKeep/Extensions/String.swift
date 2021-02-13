//
//  File.swift
//  E-commerce App
//
//  Created by taima on 10/3/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var image_: UIImage? {
        return UIImage.init(named: self)
    }
    
    var color_: UIColor {
        return UIColor.hexStringToUIColor (hex: self)
    }
    
    var localized_: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var myColor: UIColor {
        return UIColor(named: self) ?? .gray
    }
    
    func toFont( size: CGFloat = 12) -> UIFont? {
        return UIFont(name: self, size: size) ?? UIFont(name: "Arial", size: size)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    func toDate(customFormat: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        dateFormatter.dateFormat = customFormat
        return dateFormatter.date(from: self) ?? Date()
    }
    

    var html2Attributed: NSAttributedString? {
        do {
            guard let data = data(using: String.Encoding.utf8) else {
                return nil
            }
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            print("error: ", error)
            return nil
        }
    }
    
    
    

}
