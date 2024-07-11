//
//  Login.swift
//  Crystalite
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI

struct VistaLogin: View {
    
    // Variables
    
    @EnvironmentObject var vm: ViewModel
    @Binding var iniciarSesion : Bool
    @Binding var registro : Bool
    @State var mostrarAlerta : Bool = false
    @State var valorAlerta : valorAlerta = .first
    @State var email : String = ""
    @State var contraseña : String = ""
    @Binding var iniciarSesionAdmin : Bool
    
    // View
    
    var body: some View {
        
        ZStack{
            Color("Gris").ignoresSafeArea()
            
            VStack {
                
#if Crystalite
                Image("Logo").resizable().frame(width: 180, height: 150)
                Spacer().frame(height: 40)#endif
                
#if CrystaliteEasy
                Image("LogoEasy").resizable().frame(width: 250, height: 230)
                Spacer().frame(height: 20)
#endif
                
                
                
                VStack(alignment: .leading) {
                    
                    Text("Email")
                    TextField("Introducir email", text: $email)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                    
                    Spacer().frame(height: 20)
                    
                    Text("Contraseña")
                    SecureField("Introducir contraseña", text: $contraseña)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                }
                
                Spacer().frame(height: 40)
                
                VStack{
                    
                    Button {
                        if(email == "" || contraseña == ""){
                            
                            self.valorAlerta = .first
                            self.mostrarAlerta = true
                        }else{
                            for persona in vm.personaArray{
                                if(email == persona.email && contraseña == persona.contrasena && persona.admin == false){
                                    iniciarSesion.toggle()
                                    vm.personaLogin = persona
                                    
                                }else{
                                    self.valorAlerta = .second
                                    self.mostrarAlerta = true
                                }
                                if(email == persona.email && contraseña == persona.contrasena && persona.admin == true){
                                    iniciarSesionAdmin.toggle()
                                    vm.personaLogin = persona
                                }
                            }
                        }
                    } label: {
                        Text("Iniciar Sesión")
                            .frame(width: 245, height: 59)
                            .background(Color("Azul"))
                            .tint(.black)
                            .clipShape(RoundedRectangle (cornerRadius: 19))
                    }.alert(isPresented: $mostrarAlerta) {
                        switch valorAlerta {
                        case .first:
                            return Alert(title: Text("Faltan campos por rellenar"), message: Text("Rellene todos los campos"), dismissButton: .default(Text("Vale")))
                        case .second:
                            return Alert(title: Text("Credenciales incorrectas"), message: Text("Vuelve a intentarlo"), dismissButton: .default(Text("Vale")))
                        }
                    }
                    HStack{
                        
                        VStack{
                            Divider()
                                .frame(width: 100)
                                .background(Color.black)
                        }
                        Text(" o ")
                        
                        VStack{
                            Divider()
                                .frame(width: 100)
                                .background(Color.black)
                        }
                    }
                    
                    Button {
                        registro.toggle()
                    } label: {
                        Text("Registro")
                            .frame(width: 245, height: 59)
                            .background(Color("Azul"))
                            .tint(.black)
                            .clipShape(RoundedRectangle (cornerRadius: 19))
                    }
                    
                    if (iniciarSesionAdmin == true){
                        
                        VistaPrincipal(selec: 1, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin)
                        
                    }
                    if (iniciarSesion == true){
                        
                        VistaPrincipal(selec: 1, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin)
                        
                    }
                    if (registro == true) {
                        VistaRegistro(registro: $registro, iniciarSesion: $iniciarSesion, iniciarSesionAdmin: $iniciarSesionAdmin)
                    }
                    
                }
            }
        }
    }
}
