//
//  TestView.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

struct TestView: View {

    @EnvironmentObject private var coordinator: Coordinator
    @EnvironmentObject private var viewModel: AppViewModel
        
    var body: some View {
        VStack {
                Text("Тест интернет-соединения")
                    .bold()
                    .font(.title2)
                    .padding(.bottom, 25)
            
                
                HStack {
                    if viewModel.downloadTestSelected {
                        VStack {
                            Text("Скорость загрузки:")
                                .foregroundColor(.white)
                            Text("\(viewModel.downloadSpeed) Mbps")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                        }
                        .frame(width: 180, height: 80)
                        .background(Color.gray, in: RoundedRectangle(cornerRadius: 8))
                        
                    }
                    if viewModel.uploadTestSelected {
                        VStack {
                            Text("Скорость отдачи:")
                                .foregroundColor(.white)
                            Text("\(viewModel.uploadSpeed) Mbps")
                                .foregroundColor(.white)
                                .bold()
                                .font(.title2)
                        }
                        .frame(width: 180, height: 80)
                        .background(Color.gray, in: RoundedRectangle(cornerRadius: 8))
                    }
                }
                .padding(.bottom, 400)
                
              
               
                Button("Начать тест"){
                    viewModel.startTest()
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .bold()
                .background(Color.accentColor, in: RoundedRectangle(cornerRadius: 100))
                
              
                Spacer()
            }
         .environmentObject(viewModel)
         .environmentObject(coordinator)
            .padding(.vertical, 70)
            .onDisappear {
                viewModel.cancelTest()
                
            }
        }
    }


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
            .environmentObject(Coordinator())
            .environmentObject(AppViewModel())
    }
}
