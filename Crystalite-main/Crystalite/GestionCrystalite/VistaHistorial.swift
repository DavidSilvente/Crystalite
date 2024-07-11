//
//  HistorialView.swift
//  Crystalite
//
//  Created by Aula11 on 18/11/22.
//

import SwiftUI
import CoreData

struct VistaHistorial: View {
    
    // Variables
    
    @EnvironmentObject var vm : ViewModel
    @State var query: String = ""
    @State var opcionEnsayo : OpcionEnsayo = .todos
    @State var nomCreador : String = "Creador"
    
    // View
    
    var body: some View {
        
        NavigationView{
            
            ZStack(alignment: .top){
                
                Color("Gris").ignoresSafeArea()
                
                VStack{
                    VStack{
                        
                        Text("Historial")
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                            .frame(alignment: .center)
                            .font(.title)
                        
                        BusquedaView(text: $query)
                        
                        Spacer().frame(height: 10)
                        
                        HStack(){
                            Text("Mostrar: ")
                                .frame(alignment: .leading)
                                .foregroundColor(vm.modoOscuro ? .white : .black)
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 20)
                        
                        
                        Picker("", selection: $opcionEnsayo){
                            
                            ForEach(OpcionEnsayo.allCases, id: \.self){ opcion in
                                Text(opcion.rawValue)
                            }
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .padding(.top, -20)
                    
                    
                    HStack{
                        Text("Fecha")
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                            .padding(.leading,20)
                        Text("Ensayos")
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                            .padding(.leading,20)
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ScrollView{
                        
                        if(vm.personaLogin.admin == false){
                            
                            if let ensayoPersona = vm.personaLogin.ensayoRelation?.allObjects as? [EnsayoEntity]{
                                
                                if(ensayoPersona.isEmpty){
                                    
                                    VStack{
                                        Image(systemName: "exclamationmark.circle")
                                            .resizable()
                                            .frame(width: 120, height: 120)
                                            .foregroundColor(.red)
                                        Text("Actualmente no hay ensayos")
                                    }
                                    .padding(.top, 120)
                                    .frame(alignment: .center)
                                    
                                }else{
                                    
                                    ForEach(ensayoPersona){ ensayo in
                                        if(query.isEmpty){
                                            if(opcionEnsayo == .enProceso){
                                                if(ensayo.enProceso){
                                                    NavigationLink(destination: VistaEditarEnProceso(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                    }
                                                }
                                            }else{
                                                
                                                if(ensayo.enProceso){
                                                    NavigationLink(destination: VistaEditarEnProceso(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                    }
                                                }else{
                                                    NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                    }
                                                }
                                            }
                                            
                                        }else{
                                            if((ensayo.nombre ?? "" ).contains(query)){
                                                if(opcionEnsayo == .enProceso){
                                                    if(ensayo.enProceso){
                                                        NavigationLink(destination: VistaEditarEnProceso(ensayo: ensayo)){
                                                            estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                        }
                                                    }
                                                }else{
                                                    if(ensayo.enProceso){
                                                        NavigationLink(destination: VistaEditarEnProceso(ensayo: ensayo)){
                                                            estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                        }
                                                    }else{
                                                        NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                            estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: false, creador: nomCreador)
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }else{
                            
                            if(vm.ensayoArray.isEmpty){
                                
                                VStack{
                                    Image(systemName: "exclamationmark.circle")
                                        .resizable()
                                        .frame(width: 120, height: 120)
                                        .foregroundColor(.red)
                                    Text("Actualmente no hay ensayos")
                                }
                                .padding(.top, 120)
                                .frame(alignment: .center)
                                
                            }else{
                                
                                ForEach(vm.ensayoArray){ ensayo in
                                    if(query.isEmpty){
                                        if(opcionEnsayo == .enProceso){
                                            if(ensayo.enProceso){
                                                NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                    estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                }
                                            }
                                        }
                                        else{
                                            
                                            if(ensayo.enProceso){
                                                NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                    estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                }
                                            }else{
                                                NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                    estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                }
                                            }
                                        }
                                        
                                    }else{
                                        if((ensayo.nombre ?? "" ).contains(query)){
                                            if(opcionEnsayo == .enProceso){
                                                if(ensayo.enProceso){
                                                    NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                    }
                                                }
                                            }else{
                                                if(ensayo.enProceso){
                                                    NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                    }
                                                }else{
                                                    NavigationLink(destination: VistaInfoDetallada(ensayo: ensayo)){
                                                        estudioHistorial(proceso: ensayo.enProceso, tipoCristal: ensayo.resultCristal ?? "", nombreEnsayo: ensayo.nombre ?? "", fecha: ensayo.fecha ?? Date(), admin: true, creador: ensayo.creador ?? "")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                }.padding(.top,-60)
            }
        }
    }
}
