//
//  Coordinator.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

class Coordinator: ObservableObject {
    
    //MARK: Coordinator управляет логикой смены и отобажения страниц
    // Логику смены страниц завязана на кнопках TabBarView
    
    @Published var path = NavigationPath()
    @Published var startPage = Page.main
    @Published var pushDirection = Edge.trailing
    
    // Список страниц приложения
    enum Page {
        case main
        case preferences
    }
    
    // Список страниц для таббара
    let tabs: [Page] = [.main, .preferences]
    
    // Метод с логикой смены страницы
    func changeTab(to page: Page) {
        if (startPage != page) {
            if (tabs.firstIndex(of: startPage) ?? Int.max < tabs.firstIndex(of: page) ?? Int.max) {
                pushDirection = .trailing
            } else {
                pushDirection = .leading
            }
            withAnimation {
                path.removeLast(path.count)
                startPage = page
            }
        }
    }
    
    //Метод для создания вью страниц
    @ViewBuilder func view(for page: Page) -> some View {
        switch page {
        case .main:
            TestView()
        case .preferences:
            SettingsView()
        }
    }
}

extension Coordinator.Page: Identifiable, Hashable {
    
    // Identifiable func
    static func == (lhs: Coordinator.Page, rhs: Coordinator.Page) -> Bool {
        lhs.id == rhs.id
    }
    
    // Hashable func
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
   
    //id страниц, используются для перключения и подстановки иконок и названия
    var id: String {
        switch self {
        case .main:
            return "Главная"
        case .preferences:
            return "Настройки"
        }
    }

}
