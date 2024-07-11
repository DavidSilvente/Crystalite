//
//  VistaInfoDetallada.swift
//  Crystalite
//
//  Created by Aula11 on 26/11/22.
//

import SwiftUI

struct VistaInfoDetallada: View {
    
    // Variables
    
    @EnvironmentObject var vm: ViewModel
    @State var disposicion : Bool = false
    @State var cambiarNomEnsayo : Bool = false
    @State var currentNomEnsayo : String = ""
    @State var ensayo : EnsayoEntity
    @State private var showmodal = false
    @State var elemento : ElementoEntity = ElementoEntity()
    @State var count : Int = 0
    @State var mostrarAlerta : Bool = false
    @State var valorAlerta : valorAlerta = .first
    
    // View
    
    var body: some View {
        
        ZStack(alignment: .top){
            Color("Gris").ignoresSafeArea()
            
            VStack{
                Text("Informacion detallada")
                    .font(.title)
                    .foregroundColor(vm.modoOscuro ? .white : .black)
                
                Spacer().frame(height: 30)
                
                elementoCristalEdicion(tipoCristal: ensayo.resultCristal ?? "Ensayo",
                                       nombreEnsayo: ensayo.nombre ?? "Nombre", fecha: ponerFecha(fecha: ensayo.fecha ?? Date()), ensayo: ensayo)
                
                Spacer().frame(height: 40)
                
                HStack{
                    Text("Variables usadas (6)")
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    
                    Spacer().frame(width: 80)
                    if(vm.personaLogin.admin == false){
                        Button(){
                            
                            self.mostrarAlerta = true
                            
                        }label:{
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.red)
                        }.alert(isPresented: $mostrarAlerta) {
                            Alert(title: Text("Eliminar Ensayo"),
                                  message: Text("¿Desea eliminar el ensayo?"), primaryButton: .destructive(Text("Eliminar")){
                                vm.deleteEnsayo(ensayo: ensayo)
                            }, secondaryButton: .cancel(Text("Cancelar")))
                        }
                    }
                    Spacer().frame(width: 20)
                    
                    Button(){
                        disposicion.toggle()
                       
                    }label: {
                        Image(systemName: disposicion ? "list.dash" : "square.grid.3x3.topleft.filled")
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                    }
                    
                }.frame(width: 300, alignment: .leading)
                
                if disposicion == false{
                    ScrollView{
                        
                        ForEach(vm.elementoArray){ ele in
                            Button(){
                                showmodal.toggle()
                                elemento = ele
                            }label: {
                                elementoResultadoFila(iniciales: ele.iniciales ?? "",
                                                      nombre: ele.nombre ?? "",value: ObtenerValor(elemento: ele, ensayo: ensayo) )
                            }.sheet(isPresented: $showmodal, content: {
                                ViewDescripcionElemento(elemento: $elemento)
                            })
                        }
                        
                    }
                }else{
                    HStack{
                        ForEach(vm.elementoArray){ ele in
                            
                            if(vm.elementoArray.firstIndex(of: ele) ?? 3 < 3){
                                Button(){
                                    showmodal.toggle()
                                    elemento = ele
                                }label: {
                                    elementoResultadoCuadrado(iniciales: ele.iniciales ?? "",
                                                              value: ObtenerValor(elemento: ele, ensayo: ensayo))
                                }.sheet(isPresented: $showmodal, content: {
                                    ViewDescripcionElemento(elemento: $elemento)
                                })
                                if(vm.elementoArray.firstIndex(of: ele) ?? 3 < 2){
                                    Spacer().frame(width: 20)
                                }
                                
                            }
                            
                        }
                    }
                    Spacer().frame(height: 20)
                    HStack{
                        ForEach(vm.elementoArray){ ele in
                            
                            if(vm.elementoArray.firstIndex(of: ele) ?? 3 >= 3){
                                Button(){
                                    showmodal.toggle()
                                    elemento = ele
                                }label: {
                                    elementoResultadoCuadrado(iniciales: ele.iniciales ?? "",
                                                              value: ObtenerValor(elemento: ele, ensayo: ensayo))
                                }.sheet(isPresented: $showmodal, content: {
                                    ViewDescripcionElemento(elemento: $elemento)
                                })
                                if(vm.elementoArray.firstIndex(of: ele) ?? 3 < 5){
                                    Spacer().frame(width: 20)
                                }
                            }
                            
                        }
                    }
                    
                }
            }.padding(.top,-50)
        }
    }
}


