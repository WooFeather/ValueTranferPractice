//
//  Dictionary+.swift
//  SeSACDay22Assignment
//
//  Created by 조우현 on 1/23/25.
//

import Foundation

extension Dictionary where Value: Equatable {
    func findKey(forValue val: Value) -> Key? {
        return first(where: { $1 == val })?.key
    }
}
