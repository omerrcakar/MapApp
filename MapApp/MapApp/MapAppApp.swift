//
//  MapAppApp.swift
//  MapApp
//
//  Created by ÖMER  on 1.04.2025.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm) // ViewModel'i Environment'a ekliyoruz ,  tüm alt view’lere aktardık.
        }
    }
}

// Bu yapı sayesinde, başka bir alt view (örneğin LocationDetailView) oluşturduğunda da @EnvironmentObject kullanarak ViewModel’e erişebilirsin
