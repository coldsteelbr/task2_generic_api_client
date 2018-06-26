//
//  Utils.swift
//  task2_generic_api_client
//
//  Created by Roman Brazhnikov on 26.06.2018.
//  Copyright © 2018 Roman Brazhnikov. All rights reserved.
//

import Foundation

/// Convinience class with necessary util methods
class Utils {
    
    /// returns an random integer value from the range 0..<max
    static func randFromZeroTo(_ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}
