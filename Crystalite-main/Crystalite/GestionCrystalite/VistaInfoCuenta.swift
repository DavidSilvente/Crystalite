//
//  VistaInfoCuenta.swift
//  Crystalite
//
//  Created by Aula11 on 25/11/22.
//

import SwiftUI

struct VistaInfoCuenta: View {
    
    // Variables
    
    @EnvironmentObject var vm: ViewModel
    @State private var showGreeting = false
    @Binding var iniciarSesion : Bool
    @State var registro : Bool = false
    @State var mostrarEditarContrasena: Bool = false
    @State var mostrarEditarNombre: Bool = false
    @State var newPass : String = ""
    @State var newName : String = ""
    @State var pulsarBoton : Bool = false;
    @Binding var iniciarSesionAdmin : Bool
    
    // View
    
    var body: some View {
        ZStack(alignment: .top){
            Color("Gris").ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .leading) {
                    Form{
                        
                        HStack(){
                            Spacer()
                            
                            Image(uiImage: UIImage(data: vm.personaLogin.foto ?? Data())!)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(5)
                            Spacer()
                        }
                        
                        Section(header: Text("Información Básica")){
                            
                            HStack(alignment: .top) {
                                Text("Nombre Usuario")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                                Text(vm.personaLogin.nombre ?? "")
                                    .font(.subheadline)
                            }
                            
                            VStack{
                                
                                HStack(alignment: .top) {
                                    Text("Correo")
                                        .font(.subheadline)
                                        .bold()
                                    Spacer()
                                    Text(vm.personaLogin.email ?? "")
                                        .font(.subheadline)
                                    if mostrarEditarNombre == false{
                                        Image(systemName: "square.and.pencil")
                                            .onTapGesture {
                                                mostrarEditarNombre = true
                                            }
                                    }
                                }
                                if mostrarEditarNombre{
                                    HStack{
                                        TextField("Nuevo nombre", text: $newName )
                                        HStack{
                                            
                                            Button{
                                                vm.editCorreoPersona(persona: vm.personaLogin, correoNuevo: newName)
                                                newName = ""
                                                mostrarEditarNombre = false
                                            }label: {
                                                Image(systemName: "arrow.right")
                                                    .tint(.green)
                                            }
                                        }
                                        
                                    }
                                    
                                }
                            }
                            
                            VStack{
                                HStack(alignment: .top) {
                                    
                                    Text("Contraseña")
                                        .font(.subheadline)
                                        .bold()
                                    Spacer()
                                    Text(vm.personaLogin.contrasena ?? "")
                                        .font(.subheadline)
                                    if mostrarEditarContrasena == false{
                                        Image(systemName: "square.and.pencil")
                                            .onTapGesture {
                                                mostrarEditarContrasena = true
                                            }
                                    }
                                    
                                }
                                if mostrarEditarContrasena{
                                    HStack{
                                        TextField("Nueva contraseña", text: $newPass )
                                        Button{
                                            vm.editContrasenaPersona(persona: vm.personaLogin, contrasenaNueva: newPass)
                                            newPass = ""
                                            mostrarEditarContrasena = false
                                        }label: {
                                            Image(systemName: "arrow.right")
                                            .tint(.green)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        Section(header: Text("Adicional")){
                            Toggle("Modo Oscuro", isOn: $showGreeting)
                                .onChange(of: showGreeting){ value in
                                    if(value == true){
                                        vm.modoOscuro = true
                                        
                                    }else{
                                        vm.modoOscuro = false
                                        self.pulsarBoton = true;
                                    }
                                }
                            
                            
                            HStack(alignment: .top) {
                                
                                Button(){
                                    if(iniciarSesion){
                                        iniciarSesion.toggle()
                                    }else {
                                        iniciarSesionAdmin.toggle()
                                    }
                                    
                                }label:{
                                    Text("Cerra Sesión")
                                        .font(.subheadline)
                                        .bold()
                                        .foregroundColor(.red)
                                }
                            }
                            if (iniciarSesion == false && iniciarSesionAdmin == false){
                                VistaLogin(iniciarSesion: $iniciarSesion, registro: $registro, iniciarSesionAdmin: $iniciarSesionAdmin).environmentObject(vm)
                            }
                            
                        }
                        
                    }
                    .preferredColorScheme(vm.modoOscuro ? .dark : .light)
                    
                    Spacer()
                }
            }
            
        }
    }
}
