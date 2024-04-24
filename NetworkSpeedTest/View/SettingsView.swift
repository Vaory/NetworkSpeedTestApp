//
//  SettingsView.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: AppViewModel
    
    var body: some View {
        VStack {
            
            VStack(alignment: .leading) {
                
                
                Text("Введите URL для проверки соединения")
                    .bold()
                
                TextField("Enter URL", text: $viewModel.urlInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocorrectionDisabled()
                
                Spacer().frame(height: 70)
                
                Toggle(isOn: $viewModel.downloadTestSelected) {
                    Text("Измерять скорость загрузки")
                }
                
                Toggle(isOn: $viewModel.uploadTestSelected) {
                    Text("Измерять скорость отдачи")
                }
                
                Spacer().frame(height:70)
                
                Text("Выбор цветовой темы приложения")
                    .bold()
                Picker(selection: $viewModel.selectedThemeIndex, label: Text("Select Theme")) {
                    Text("*Системная").tag(0)
                    Text("Светлая").tag(1)
                    Text("Тёмная").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                
                Spacer().frame(height: 70)
            }
        }
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Coordinator())
            .environmentObject(AppViewModel())
    }
}
