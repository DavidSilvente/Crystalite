//
//  ViewDescripcionElemento.swift
//  Crystalite
//
//  Created by Aula11 on 30/12/22.
//

import SwiftUI

struct ViewDescripcionElemento: View {
    
    // Variables

    @EnvironmentObject var vm: ViewModel
    @Binding var elemento : ElementoEntity
    
    // View
    
    var body: some View{
        
        ZStack(){
            Color("Gris").ignoresSafeArea()
            
            Circle()
                .fill(Color("Azul"))
                .frame(width: 500, height: 500)
                .padding(.top,-500)
            
            VStack(alignment: .center){
                Image(elemento.iniciales ?? "")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.top,50)
                
                Text(elemento.nombre ?? "").font(.title2)
                    .padding(.top, 100)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Divider()
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Text(elemento.descripcion ?? "")
                    .padding(.horizontal, 100)
                    .multilineTextAlignment(.center)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                
            }
        }
        
    }
}

struct ViewDescripcionCristal: View {
    
    // Variables
    
    @EnvironmentObject var vm: ViewModel
    @State var cristal : CristalEntity
    
    // View
    
    var body: some View{
        
        ZStack(){
            Color("Gris").ignoresSafeArea()
            
            Circle()
                .fill(Color("Azul"))
                .frame(width: 500, height: 500)
                .padding(.top,-500)
            
            VStack(alignment: .center){
                Image(cristal.nombre ?? "")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .padding(.top,50)
                
                Text(cristal.nombre ?? "").font(.title2)
                    .padding(.top, 100)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Divider()
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Text(cristal.descripcion ?? "")
                    .padding(.horizontal, 100)
                    .multilineTextAlignment(.center)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                
            }
        }
        
    }
}

