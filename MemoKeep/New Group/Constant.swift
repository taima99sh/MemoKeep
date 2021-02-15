//
//  Constant.swift
//  MemoKeep
//
//  Created by taima on 2/10/21.
//  Copyright © 2021 mac air. All rights reserved.
//

import Foundation
import UIKit

class Constant {
    
static let shared = Constant()
var memoBooks: [MemoBook] = []
var ProjectFont = "Helvetica Neue W23 for SKY"
    
    enum MemoColor {
        case red
        case black
        case white
        case purple
        case blue
        
        var colorName: Int{
            switch self {
            
            case .red:
                return 0
            case .black:
                return 1
            case .white:
                return 2
            case .purple:
                return 3
            case .blue:
                return 4
            }
        }
        
     var color: UIColor {
      switch self {
        
      case .red:
          return #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 0.444536601)
      case .black:
          return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 0.5999571918)
      case .white:
          return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      case .purple:
          return #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 0.4207512842)
      case .blue:
          return #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 0.5404537671)
      
      }
     }
       
    }
    
}
