//
//  AppViewModel.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI
import NDT7

class AppViewModel: ObservableObject {
    
    @Published var urlInput: String = "https://github.com"
    @Published var downloadTestSelected: Bool = true
    @Published var uploadTestSelected: Bool = true
    @Published var downloadSpeed: String = "__.__"
    @Published var uploadSpeed: String = "__.__"
    @Published var selectedThemeIndex: Int = 0
    private var ndt7Test: NDT7Test?
    
    // Метод для запуска теста принимает в себя переменные downloadTestSelected,  uploadTestSelected для выполнения тестов согласно чекбоксам
    func startTest() {
        guard let url = URL(string: urlInput) else {
            print("Invalid URL")
            return
        }
        let settings = NDT7Settings()
        ndt7Test = NDT7Test(settings: settings)
        ndt7Test?.delegate = self
        ndt7Test?.startTest(download: downloadTestSelected, upload: uploadTestSelected) { [weak self] (error) in
            if let error = error {
                print("NDT7 iOS Example app - Error during test: \(error.localizedDescription)")
            } else {
                print("NDT7 iOS Example app - Test finished.")
            }
        }
    }
    
    //Отмена теста(в функционал приложения пока не включил)
    func cancelTest() {
        ndt7Test?.cancel()
    }
}

//Расширение для отображения скорости загрузки и выгрузки
//Поскольку в фреймфорке NDT7 нету функций измерения скоростей из коробки - пришлось их тянуть в ручную из mesasurement значений и приводить в мегабиты в секунду (по умалчанию было байты в милисекунду)
extension AppViewModel: NDT7TestInteraction {
    func test(kind: NDT7TestConstants.Kind, running: Bool) {
    }

    func measurement(origin: NDT7TestConstants.Origin, kind: NDT7TestConstants.Kind, measurement: NDT7Measurement) {
        switch kind {
        case .download:
            if let numBytes = measurement.appInfo?.numBytes, let elapsedTime = measurement.appInfo?.elapsedTime {
                let speed = (((Double(numBytes) * 8) / (Double(elapsedTime) / 1_000_000))) / 1_000_000
                downloadSpeed = String(format: "%.2f", speed)
            }
        case .upload:
            if let numBytes = measurement.appInfo?.numBytes, let elapsedTime = measurement.appInfo?.elapsedTime {
                let speed = (((Double(numBytes) * 8) / (Double(elapsedTime) / 1_000_000))) / 1_000_000
                uploadSpeed = String(format: "%.2f", speed)
            }
        }
    }

    func error(kind: NDT7TestConstants.Kind, error: NSError) {
        print("NDT7 iOS Example app - Error during test: \(error.localizedDescription)")
    }
}
