//
//  LocationsView.swift
//  MapApp
//
//  Created by ÖMER  on 1.04.2025.
//

import SwiftUI
import MapKit


struct LocationsView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel // ViewModel'i burada kullanıyoruz
    
    var body: some View {
        ZStack{
            withAnimation(.easeInOut){
                mapLayer
                    .edgesIgnoringSafeArea(.all)
            }
            
            VStack(spacing: 0){
                header
                    .padding()
                
                Spacer()
                locationsPreviewStack
            }
            
            
        }
    }
}

extension LocationsView {
    private var header: some View {
        VStack {
            Button{
                withAnimation(.easeInOut){
                    vm.toggleLocationsList()
                }
            }label: {
                Text(vm.mapLocation.name + ", " + vm.mapLocation.cityName)
                    .font(.title2)
                    .fontWeight(.black)
                    .foregroundStyle(.primary)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .leading){
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundStyle(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showLocationsList ? 180 : 0))
                    }
            }
            if vm.showLocationsList{
                LocationsListView()
            }
            
            
        }
        .background(
            Color.white,
            in: RoundedRectangle(cornerRadius: 10, style: .continuous)
        )
        .shadow(color:Color.black.opacity(0.3) ,radius: 20, x: 0, y: 15)
    }
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion,
            annotationItems: vm.locations,
            annotationContent: { location in
            MapAnnotation(coordinate: location.coordinates) {
                LocationMapAnnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        })
    }
    
    private var locationsPreviewStack: some View {
        ZStack{
            ForEach(vm.locations){ location in
                if vm.mapLocation == location{ // Seçili konum eşleştiğinde göster
                    // Bu durumda ForEach içindeki location her seferinde değişir, ancak sadece mapLocation ile eşleştiğinde LocationPreviewView gösterilir.
                    LocationPreviewView(location: location)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
                
            }
        }
    }
}

#Preview {
    LocationsView()
        .environmentObject(LocationsViewModel())
}
