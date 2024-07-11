//
//  Componentes.swift
//  Crystalite
//
//  Created by Aula11 on 25/11/22.
//
import Foundation
import SwiftUI

extension UIColor{
    static let myCustomColor = UIColor(red: 0.229, green: 0.234, blue: 0.245, alpha: 0)
}

enum OpcionEnsayo : String, CaseIterable{
    case todos = "Todos"
    case enProceso = "En proceso"
}

enum valorAlerta {
    case first, second
}


struct boton: View{
    
    var texto : String;
    var vista : AnyView;
    
    var body:some View{
        
        
        NavigationLink(destination: vista){
            Label(texto, systemImage: "app.badge")
                .frame(width: 245, height: 59)
                .background(Color("Azul"))
                .tint(.black)
                .clipShape(RoundedRectangle (cornerRadius: 19))
                .padding(.all, 15)
                .labelStyle(TitleOnlyLabelStyle())
            
        }
    }
}

struct ElementoView: View{
    
    @EnvironmentObject var vm: ViewModel
    
    var elemento : ElementoEntity
    @State var valor : Double = 0.0
    @State var altura: CGFloat = 60
    @State var mostrarSlider : Bool = false
    @State var valorFinal : String = ""
    @State var valorSlider: Double = 0.0
    
    var body:some View{
        VStack(){
            HStack (){
                Image(elemento.iniciales ?? "")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .clipShape(RoundedRectangle (cornerRadius: 10))
                
                VStack(alignment: .leading) {
                    Text(elemento.iniciales ?? "")
                        .font(.title3)
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    
                    Text(elemento.nombre ?? "")
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    
                }.frame(width: 150, alignment: .leading)
                
                TextField(String(valor), text: $valorFinal, onEditingChanged: {editing  in
                    vm.editElemento(elemento: elemento, valorNuevo: Double(valorFinal) ?? 1)
                })
                .foregroundColor(vm.modoOscuro ? .white : .black)
                .frame(width: 50)
                
                
                Button{
                    mostrarSlider.toggle()
                    if mostrarSlider{
                        altura=100
                    }else{
                        altura=60
                    }
                }label: {
                    Image(systemName: "plus.circle")
                }
                
            }
            
            
            if mostrarSlider {
                VStack{
                    Slider(value: $valorSlider, in: 0.0...20.0,
                           onEditingChanged:{ editing in
                        valorFinal = String(format: "%.2f", valorSlider)
                        vm.editElemento(elemento: elemento, valorNuevo: valorSlider)
                    }
                    ).frame(width: 280)
                }
            }
        }
        .frame(width: 300, height: altura)
        .background(vm.modoOscuro ? .black : .white)
        .cornerRadius(15)
        .onAppear(){
            valorFinal = String(format: "%.2f", elemento.valor)
            mostrarSlider = false
            altura = 60
        }
        
    }
    
}

struct estudioHistorial: View{
    
    @EnvironmentObject var vm: ViewModel
    var proceso: Bool
    var tipoCristal: String
    var nombreEnsayo: String
    var fecha: Date
    var admin : Bool
    var creador : String
    
    var body:some View{
        ZStack{
            Color("Gris").ignoresSafeArea()
            VStack(alignment: .leading){
                HStack{
                    Text(ponerFechaPeq(fecha: fecha)).font(.system(size: 13))
                        .tint(vm.modoOscuro ? .white : .black)
                    Label("", systemImage: "circle.inset.filled")
                        .tint(vm.modoOscuro ? .white : Color("Morado"))
                    HStack (){
                        
                        VStack(alignment: .leading) {
                            Text(tipoCristal)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 15))
                                .tint(vm.modoOscuro ? .white : .black)
                            Text("Nombre: \(nombreEnsayo)").font(.caption).tint(vm.modoOscuro ? .white : .black)
                            if proceso{
                                Text("")
                                Text("En proceso").font(.caption).tint(.red)
                                
                            }
                            
                            if(admin == true){
                                Text("")
                                Text("Creador: \(creador)").font(.caption).tint(vm.modoOscuro ? .white : .black)
                            }
                        }.padding(.leading)
                            .frame(width: 170, alignment: .leading)
                        
                        Image(tipoCristal)
                            .resizable()
                            .frame(width: 125, height: 100)
                            .clipShape(RoundedRectangle (cornerRadius: 10))
                            .background(vm.modoOscuro ? .white : .white)
                            .cornerRadius(10)
                        
                    }
                    .frame(width: 280, height: 100)
                    .background(vm.modoOscuro ? .black : .white)
                    .cornerRadius(15)
                }
            }
            
            
        }
    }
}



struct elementoCristalEdicion: View{
    
    @EnvironmentObject var vm: ViewModel
    var tipoCristal: String
    @State var nombreEnsayo: String
    var fecha: String
    @State var cambiarNombre : Bool = false
    @State var currentNomEnsayo = ""
    @State var ensayo : EnsayoEntity
    @State var ele_cristal : CristalEntity = CristalEntity()
    @State private var showcristal = false
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(tipoCristal)
                    .font(.body)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                vm.personaLogin.admin == false ? Spacer().frame(height: 0.1) : Spacer().frame(height: 10)
                
                HStack{
                    
                    Text("Nombre: \(nombreEnsayo)").font(.caption)
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    
                    if(vm.personaLogin.admin == false){
                        Button() {
                            cambiarNombre.toggle()
                            if !cambiarNombre {
                                if(currentNomEnsayo.isEmpty){
                                    nombreEnsayo = nombreEnsayo
                                    vm.editNombreEnsayo(ensayo: ensayo, nombrenuevo: nombreEnsayo)
                                }else {
                                    nombreEnsayo = currentNomEnsayo
                                    vm.editNombreEnsayo(ensayo: ensayo, nombrenuevo: currentNomEnsayo)
                                    
                                }
                            }
                        } label: {
                            Image(systemName: (cambiarNombre ? "pencil.slash":"pencil" ))
                                .resizable()
                                .frame(width: 10, height: 10)
                                .padding()
                                .foregroundColor(.gray)
                        }
                    }
                }
                if cambiarNombre {
                    TextField("Nuevo nombre...", text:$currentNomEnsayo)
                        .font(.caption2)
                        .padding(.horizontal,15)
                        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
                        .foregroundColor(.black)
                        .cornerRadius(5)
                        .frame(width: 150, height: 40, alignment: .leading)
                        .padding(.top,-30)
                }
                
                vm.personaLogin.admin == false ? Spacer().frame(height: 0.1) : Spacer().frame(height: 10)
                
                Text(fecha)
                    .font(.caption)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
            }
            .frame(width: 180, height: 100, alignment: .leading)
            .padding(.leading, -30)
            
            Button(){
                
//                for cristal in vm.cristalArray{
//                    if (cristal.nombre == tipoCristal) {
//                        ele_cristal = cristal
//                    }
//                }
                
//                showcristal.toggle()
            }label: {
                Image(tipoCristal)
                    .resizable()
                    .frame(width: 125, height: 100, alignment: .trailing)
                    .background(vm.modoOscuro ? .white : .white)
                    .cornerRadius(15)
                    .padding(.trailing,-50)
                
            }.sheet(isPresented: $showcristal, content: {
                // ViewDescripcionCristal(cristal: ele_cristal)
            })
            
        }
        .frame(width: 320, height: 100)
        .background(vm.modoOscuro ? .black : .white)
        .cornerRadius(15)
    }
}

struct elementoResultadoFila: View{
    
    @EnvironmentObject var vm: ViewModel
    
    var iniciales : String;
    var nombre : String;
    var value : Double;
    
    var body: some View{
        
        HStack (){
            Image(iniciales)
                .resizable()
                .frame(width: 35, height: 35)
                .clipShape(RoundedRectangle (cornerRadius: 10))
            VStack(alignment: .leading) {
                Text(iniciales).tint(.black)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Text(nombre).tint(.black)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
            }.frame(width: 170, alignment: .leading)
            Text(String(format: "%.2f",value)).frame(width: 50)
                .foregroundColor(vm.modoOscuro ? .white : .black)
            
        }
        .frame(width: 300, height: 60)
        .background(vm.modoOscuro ? .black : .white)
        .cornerRadius(15)
        
    }
    
}

struct elementoResultadoCuadrado: View{
    @EnvironmentObject var vm: ViewModel
    
    var iniciales : String;
    var value : Double;
    
    var body: some View{
        VStack (alignment: .center){
            Image(iniciales)
                .resizable()
                .frame(width: 35, height: 35)
                .clipShape(RoundedRectangle (cornerRadius: 10))
            VStack() {
                Text(iniciales).padding(.leading,-30)
                    .font(.title2)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Text(String(format: "%.2f",value))
                    .padding(.trailing,-20)
                    .frame(width: 50)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                
            }.frame(width: 55)
        }
        .frame(width: 85, height: 120)
        .background(vm.modoOscuro ? .black : .white)
        .cornerRadius(15)
    }
    
}
