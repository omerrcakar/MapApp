//
//  LocationMapAnnotationView.swift
//  MapApp
//
//  Created by ÖMER  on 2.04.2025.
//

import SwiftUI

struct LocationMapAnnotationView: View {
    @State private var animation: Double = 0.0
    
    var body: some View {
        ZStack{
            Circle()
                .fill(.red)
                .frame(width: 54, height: 54)
            Circle()
                .stroke(.red, lineWidth: 2)
                .frame(width: 52, height: 52)
                .scaleEffect(1 + CGFloat(animation))
                .opacity(1 - animation)
            Image(systemName: "map.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(6)
                .background(.red)
                .clipShape(RoundedRectangle(cornerRadius: 36))
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.red)
                .frame(width: 15, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: 48)
                .padding(.bottom, 40)
            
        }
        .onAppear{
            withAnimation(Animation.easeOut(duration: 2).repeatForever(autoreverses: false)){
                animation = 1
            }
        }
        
        
    }
}

#Preview {
    LocationMapAnnotationView()
}
