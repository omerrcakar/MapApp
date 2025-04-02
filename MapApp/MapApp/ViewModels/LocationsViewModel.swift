//
//  LocationsViewModel.swift
//  MapApp
//
//  Created by ÖMER  on 1.04.2025.
//

import Foundation
import MapKit
import SwiftUI

class LocationsViewModel: ObservableObject{
    // All loaded locations
    // Tüm konumları saklayan değişken
    @Published var locations : [Location]
    
    // Current location on map
    // Haritada seçili olan mevcut/aktif konumu tutar
    @Published var mapLocation: Location{
        didSet{ // didset: ile yeni konum seçildiğinde haritanın güncellenmesini sağlıyorsun.
            updateMapRegion(location: mapLocation)
        }
    }
    // didset : Yeni bir konum seçildiğinde (mapLocation değiştiğinde) updateMapRegion(location:) fonksiyonu çalışır ve haritanın merkezi bu yeni konuma göre ayarlanır.
    
    // Harita merkezi ve zoom seviyesini belirler.
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    // Haritanın ne kadar alanı kapsayacağını belirler (latitudeDelta, longitudeDelta küçükse daha fazla zoom olur).
    // MKCoordinateRegion, haritanın merkez noktasını ve kapsama alanını (zoom seviyesini) tanımlar.
    

    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    // Show list of locations
    @Published var showLocationsList: Bool = false
    
    init(){
        let locations = LocationsDataService.locations
        self.locations = locations
        self.mapLocation = locations.first!
        self.updateMapRegion(location: locations.first!)
    }
    // LocationsDataService.locations ile dış bir veri kaynağından konumları alırız.
    // self.locations = locations ile bu konumları locations değişkenine kaydederiz.
    // self.mapLocation = locations.first! → İlk konumu başlangıçta seçili konum olarak belirleriz.
    // self.updateMapRegion(location: locations.first!) → Harita başlangıçta ilk konumu gösterecek şekilde ayarlanır.
    
    
    // Yeni seçilen konuma göre haritayı günceller.
    private func updateMapRegion(location: Location){
        mapRegion = MKCoordinateRegion(
            center: location.coordinates,
            span: mapSpan)
    }
    
    func toggleLocationsList(){
        self.showLocationsList.toggle()
    }
    
    func showNextLocation(location: Location){
        withAnimation(.easeInOut){
            mapLocation = location // Yeni seçilen konumu atıyoruz!
            showLocationsList = false
        }
    }
    
    
    // Bu fonksiyon çalıştığında, mapLocation değişiyor ve LocationsView güncelleniyor!
    func nextButtonPressed(){
        // Get the current index
        guard let currentIndex = locations.firstIndex(where: { $0 == mapLocation }) else {
            print("Could not find current index in locations array! Should never happen")
            return
        }
        
        // $0 = Dizideki o an incelenen öğe , mapLocation = Aradığımız konum
        // Eğer $0 yani o an incelenen öğe mapLocation’a eşitse, bu öğenin index’ini döndür. Yani güncel index
        // firstIndex(where:) dizinin ilk elemanından başlayarak tek tek her öğeyi inceler.
        // $0, şu anda kontrol edilen öğedir.
        // Eğer $0 == mapLocation koşulu doğruysa, firstIndex(where:) o öğenin index’ini döndürür.
        
        // Check if the currentIndex is valid
        // Eğer listenin dışına çıktıysak, başa dön
        let nextIndex = currentIndex + 1
        guard locations.indices.contains(nextIndex) else {
            // Next index is not valid
            // Restart from 0
            guard let firstLocation = locations.first else { return }
            showNextLocation(location: firstLocation)
            return
        }
        
        // Next index is valid
        // Sonraki index geçerliyse, yeni lokasyonu ata
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}
