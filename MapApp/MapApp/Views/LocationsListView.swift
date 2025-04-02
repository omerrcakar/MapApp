//
//  LocationsListView.swift
//  MapApp
//
//  Created by ÖMER  on 2.04.2025.
//

import SwiftUI

struct LocationsListView: View {
    @EnvironmentObject private var vm: LocationsViewModel // ViewModel'i burada kullanıyoruz
    
    
    var body: some View {
        List{
            ForEach(vm.locations){ location in
                Button{
                    vm.showNextLocation(location: location)
                }label: {
                    listRowView(location: location)
                }
                .padding(.vertical, 5)
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                
                    
            }
        }
        
        .listStyle(PlainListStyle())
    }
}

extension LocationsListView {
    private func listRowView(location: Location) -> some View {
        HStack{
            if let imageName = location.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
            }
            VStack(alignment: .leading){
                Text(location.name)
                    .font(.headline)
                Text(location.cityName)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
    }
}

#Preview {
    LocationsListView()
        .environmentObject(LocationsViewModel())
}
