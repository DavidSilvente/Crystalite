//
//  CrystaliteApp.swift
//  Crystalite
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI

@main
struct CrystaliteApp: App {
    
    // Variables
    
    @StateObject private var vm: ViewModel = ViewModel()
    @State var iniciarSesion : Bool = false
    @State var registro : Bool = false
    @State var iniciarSesionAdmin : Bool = false
    
    // View
    var body: some Scene {
        
        WindowGroup {
            if(iniciarSesion == false && registro == false && iniciarSesionAdmin == false){
                VistaLogin(iniciarSesion: $iniciarSesion, registro: $registro, iniciarSesionAdmin: $iniciarSesionAdmin).environmentObject(vm)
            }
            if (iniciarSesion == true && iniciarSesionAdmin == false){
                VistaPrincipal(selec: 1, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin).environmentObject(vm)
            }
            if (registro == true && iniciarSesion == false && iniciarSesionAdmin == false){
                VistaRegistro(registro: $registro, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin).environmentObject(vm)
            }
            if(iniciarSesionAdmin == true && iniciarSesion == false){
                VistaPrincipal(selec: 1, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin).environmentObject(vm)
            }
        }
    }
}
