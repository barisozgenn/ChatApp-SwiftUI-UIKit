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
