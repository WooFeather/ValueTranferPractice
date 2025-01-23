//
//  String+.swift
//  SeSACDay22Assignment
//
//  Created by 조우현 on 1/23/25.
//

import UIKit

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.dateFormat = "yyyy년 M월 dd일"
        return dateFormatter.date(from: self)
    }
}
