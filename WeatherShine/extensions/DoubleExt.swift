//
//  DoubleExt.swift
//  WeatherShine
//
//  Created by Igor Tabacki on 2/7/18.
//  Copyright © 2018 Igor Tabacki. All rights reserved.
//

import Foundation


extension Double {
        func toInt() -> Int? {
            if self > Double(Int.min) && self < Double(Int.max) {
                return Int(self)
            } else {
                return nil
            }
        }
}
