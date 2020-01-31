//
//  Date.swift
//  Rosters App
//
//  Created by Mantas Svedas on 1/21/20.
//  Copyright © 2020 Mantas Svedas. All rights reserved.
//

import Foundation

extension Date {
    func getAgeFromDOF(date: String) -> (Int) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd"
        let dateOfBirth = dateFormater.date(from: date) ?? Date()

        let calender = Calendar.current
        let dateComponent = calender.dateComponents([.year, .month, .day], from: dateOfBirth, to: Date())

        return (dateComponent.year ?? -1)
    }
    
    func getMinutes(fromDate date: Any) -> Double{
        let timeInterval = Date().timeIntervalSince(date as? Date ?? Date()) / 60
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let roundedTimeInterval = round(timeInterval * multiplier) / multiplier
        return roundedTimeInterval
    }
}
