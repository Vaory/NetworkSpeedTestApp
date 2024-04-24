//
//  ThemeManager.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

class ThemeManager: ObservableObject {
    @Published var selectedTheme: ColorScheme = .dark
    @Published var selectedThemeIndex: Int = 0
    
}
