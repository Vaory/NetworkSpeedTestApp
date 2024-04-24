//
//  TabBarView.swift
//  NetworkSpeedTest
//
//  Created by Mikhail Demichev on 24.04.2024.
//

import SwiftUI

struct TabBarView: View {

    @EnvironmentObject var coordinator: Coordinator
    @StateObject var viewModel = AppViewModel()
    
    var body: some View {
            CustomTabBar(tabs: coordinator.tabs, selectedTab: $coordinator.startPage) { tab in
                self.coordinator.changeTab(to: tab)
            }
            .background(Color(UIColor.systemBackground))
            .edgesIgnoringSafeArea(.bottom)
        }
    }

struct CustomTabBar: View {
    let tabs: [Coordinator.Page]
    @Binding var selectedTab: Coordinator.Page
    let tabSelection: (Coordinator.Page) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs) { tab in
                Button(action: {
                    self.selectedTab = tab
                    self.tabSelection(tab)
                }) {
                    VStack(spacing: 3) {
                        Text(tab.id)
                           
                          
                    }
                    .frame(height: 70)
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

    struct TabBarView_Previews: PreviewProvider {
        static var previews: some View {
            TabBarView()
                .environmentObject(Coordinator())
        }
    }

