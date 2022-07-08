//
//  Color+init.swift
//  Breeze
//
//  Created by Brian Shao on 2022/07/07.
//

import Foundation
import SwiftUI

extension Color {
    init(rgb: Int, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255.0,
            green: CGFloat((rgb >> 8) & 0xFF) / 255.0,
            blue: CGFloat(rgb & 0xFF) / 255.0,
            opacity: alpha
        )
    }
}
