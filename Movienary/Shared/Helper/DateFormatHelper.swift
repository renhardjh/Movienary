//
//  DateFormatHelper.swift
//  Movienary
//
//  Created by RenhardJH on 20/07/23.
//

import Foundation

class DateFormatHelper {
    let formatter: DateFormatter!
    var date: Date?

    init(date: String, format: String = "yyyy-MM-dd'T'HH:mm:ss", timeZone: TimeZone? = TimeZone(secondsFromGMT: 0) ) {
        self.formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        formatter.timeZone = timeZone

        if let d = formatter.date(from: date) {
            self.date = d
        } else {
            self.checkAvailableFormat(of: date)
        }
    }

    func getDate(format: String) -> String {
        formatter.dateFormat = format
        return formatter.string(from: date ?? Date())
    }

    private func checkAvailableFormat(of date: String) {
        let knowingFormats = [
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd' 'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ssZ",
            "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            "yyyy-MM-dd'T'HH:mm:ssZZZZZ",
            "yyyy-MM-dd'T'HH:mm:ssXXX",
            "yyyy-MM-dd'T'HH:mm:ss'Z'",
            "yyyy-MM-dd",
            "yyyy-MM-dd'T'HH:mm.ss'Z'",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'",
            "dd MM yyyy",
            "yyyy-MM-dd HH:mm"
        ]

        for format in knowingFormats {
            formatter.dateFormat = format
            if let _date = formatter.date(from: date) {
                self.date = _date
            }
        }
    }
}
