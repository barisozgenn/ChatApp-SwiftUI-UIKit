//
//  Date.swift
//  ChatAppUIKit
//
//  Created by Baris OZGEN on 28.11.2022.
//

import Firebase

extension Date {
    func toTimestamp() -> Timestamp {
        return Timestamp(date: self)
    }
}
extension TimeInterval {
    func toHourMinuteString() -> String {
        let unixTime = Double(self)
        let date = Date(timeIntervalSince1970: unixTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
