//
//  UITextViewExtension.swift
//  E-commerce App
//
//  Created by taima on 9/28/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    var isValidValue: Bool {
        return !text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    
    
}
