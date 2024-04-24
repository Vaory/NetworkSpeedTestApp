//
//  CoordinatorView.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

// MARK: Основное отображение приложения
/* Координатор используется в качестве ентерпоинта приложения.
Отображает и переключает окна в соответсвии с логикой файла Coordinator.
Так-же является вью верхрнего уровня через который изменяются  @StateObject вью-моделей
и отображаються объекты environmentObject.
*/

struct CoordinatorView: View {
    
    @StateObject var coordinator = Coordinator()
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack(path: $coordinator.path) {
                ZStack {
                    coordinator.view(for: coordinator.startPage)
                        .padding(.horizontal, 17)
                        .transition(.push(from: coordinator.pushDirection))
                        .navigationDestination(for: Coordinator.Page.self) { page in
                            coordinator.view(for: page)
                                .transition(.push(from: coordinator.pushDirection))
                                .padding(.horizontal, 17)
                                .toolbar(.hidden, for: .navigationBar)
                        }
                }
            }
            
            Divider()
            
            TabBarView()
                .ignoresSafeArea(.all)
        }
        .preferredColorScheme(viewModel.selectedThemeIndex == 0 ? .none : viewModel.selectedThemeIndex == 1 ? .light : .dark)
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.all)
        .environmentObject(coordinator)
        .environmentObject(viewModel)
    }
}


struct CoordinatorView_Previews: PreviewProvider {
    static var previews: some View {
        CoordinatorView()
    }
}
