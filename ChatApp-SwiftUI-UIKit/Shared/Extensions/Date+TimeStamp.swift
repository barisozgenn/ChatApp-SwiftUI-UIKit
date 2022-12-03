//
//  Date.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import Foundation

extension Date {
    func toHourMinuteString() -> String {
        let date = Date(timeIntervalSince1970: self.timeIntervalSinceNow)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
