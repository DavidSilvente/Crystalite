//
//  Registro.swift
//  Crystalite
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI

struct VistaRegistro: View {
    
    // Variables
    
    @EnvironmentObject var vm : ViewModel
    @State var imageGeneral : UIImage = (UIImage(systemName: "person.crop.circle.badge.plus") ?? nil)!
    @State var atras : UIImage = (UIImage(systemName: "arrow.backward") ?? nil)!
    @State var mostrarImagePicker: Bool = false
    @Binding var registro : Bool
    @Binding var iniciarSesion : Bool
    @State var activarAlerta : Bool = false
    @Binding var iniciarSesionAdmin : Bool
    
    // Atributos de una persona
    
    @State var nombre : String = ""
    @State var email : String = ""
    @State var contraseña : String = ""
    @State var repeatContraseña : String = ""
    
    // View
    
    var body: some View {
        
        ZStack{
            Color("Gris").ignoresSafeArea()
            
            VStack {
                HStack{
                    Button(){
                        registro.toggle()
                        VistaLogin(iniciarSesion: $iniciarSesion, registro: $registro, iniciarSesionAdmin: $iniciarSesionAdmin)
                    }label: {
                        Image(uiImage: atras)
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                    
                }.frame(width: 350, alignment:.leading)
                    .padding(.top,-50)
                Button() {
                    mostrarImagePicker.toggle()
                    
                }label:{
                    VStack{
                        Image(uiImage: imageGeneral)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 120, height: 120, alignment: .center)
                    }
                }
                .sheet(isPresented: $mostrarImagePicker){
                    ImagePicker(sourceType: .photoLibrary){imageSeleccionada in
                        imageGeneral = imageSeleccionada
                    }
                }
                
                Spacer().frame(height: 50)
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text("Nombre")
                    TextField("Introducir nombre", text: $nombre)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                }
                .frame(width: 272, height: 58, alignment: .center)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text("Email")
                    TextField("Introducir email", text: $email)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                }
                .frame(width: 272, height: 58, alignment: .center)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text("Contraseña")
                    SecureField("Introducir contraseña", text: $contraseña)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                }
                .frame(width: 272, height: 58, alignment: .center)
                .padding(.bottom, 10)
                
                VStack(alignment: .leading, spacing: 1) {
                    
                    Text("Repetir Contraseña")
                    SecureField("Repetir contraseña", text: $repeatContraseña)
                        .padding(.leading,10)
                        .frame(width: 272, height: 34)
                        .background(.white)
                        .cornerRadius(10)
                }
                .frame(width: 272, height: 58, alignment: .center)
                .padding(.bottom, 10)
                
                Spacer().frame(height: 40)
                
                Button() {
                    if(nombre == "" || email == "" || contraseña == "" || repeatContraseña == ""){
                        activarAlerta.toggle()
                    }else{
                        vm.addPersona(nombre: nombre, foto: imageGeneral, email: email, contrasena: contraseña, admin: false)
                        registro.toggle()
                    }
                } label: {
                    Text("Registrarse")
                        .frame(width: 245, height: 59)
                        .background(Color("Azul"))
                        .tint(.black)
                        .clipShape(RoundedRectangle (cornerRadius: 19))
                }
                .alert("Rellene todos los campos", isPresented: $activarAlerta) {
                    Button("OK", role: .cancel) { }
                }
                if (registro == false) {
                    VistaLogin(iniciarSesion: $iniciarSesion, registro: $registro, iniciarSesionAdmin: $iniciarSesionAdmin)
                }
            }
        }
    }
}

struct VistaRegistro_Previews: PreviewProvider {
    static var previews: some View {
        VistaRegistro(registro: .constant(true), iniciarSesion: .constant(false), iniciarSesionAdmin: .constant(false))
    }
}
