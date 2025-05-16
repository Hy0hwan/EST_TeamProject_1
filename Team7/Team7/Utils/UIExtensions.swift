//
//  UIExtensions.swift
//  Team7
//
//  Created by Kitcat Seo on 5/13/25.
//

import Foundation
import SwiftUI

extension Color { // Hex 코드값을 색상으로 변환해주는 익스텐션
    init(hexString: String, opacity: Double = 1.0) {
        let hex: Int = Int(hexString, radix: 16)!
        
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue, opacity: opacity)
    }
}
