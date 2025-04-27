//
//  Color+Extension.swift
//  CaseManager
//
//  Created by Hoàng Nam on 8/4/25.
//

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        self.init(red: red, green: green, blue: blue)
    }
}

struct GlobalConfig {
    static let colorTheme: String = "63B5AF"
    static let colorBackgroundTheme: String = "#ecf0f1"
    static let colorWhite: String = "#ffffff"
    static let GlobalPadding: CGFloat = 15
}
