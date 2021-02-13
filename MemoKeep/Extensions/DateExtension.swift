//
//  DateExtension.swift
//  Yahia Gallery
//
//  Created by taima on 12/5/19.
//  Copyright © 2019 mac air. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    //Convert date to String
    func toString(customFormat: String, timeZone: String = "UTC") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: timeZone)
        dateFormatter.dateFormat = customFormat
        return dateFormatter.string(from: self)
    }
     var yesterday: Date { return self.dayBefore }
     var tomorrow:  Date { return self.dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }

}
