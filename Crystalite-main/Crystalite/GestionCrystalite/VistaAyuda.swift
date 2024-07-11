//
//  VistaAyuda.swift
//  Crystalite
//
//  Created by Aula11 on 25/11/22.
//

import SwiftUI

struct VistaAyuda: View {
    
    // Variables
    
    @EnvironmentObject var vm: ViewModel
    @State var query: String = ""
    @State var expand = false
    
    // View
    
    var body: some View {
        
        NavigationView{
            ZStack(alignment: .top){
                Color("Gris").ignoresSafeArea()
                
                VStack{
                    Text("Ayuda")
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                        .frame(alignment: .center)
                        .font(.title)
                    
                    BusquedaView(text: $query)
                    
                    Spacer().frame(height: 10)
                    
                    Form{
                        ForEach(vm.ayudaArray) {pregunta in
                            
                            if(query.isEmpty){
                                Section{
                                    DisclosureGroup() {
                                        Text(pregunta.respuesta ?? "Respuesta")
                                        
                                    }label: {
                                        Text(pregunta.pregunta ?? "Pregunta")
                                            .fontWeight(.semibold)
                                        
                                    }
                                }
                            }else{
                                if((pregunta.pregunta ?? "").contains(query.lowercased())){
                                    
                                    Section{
                                        DisclosureGroup() {
                                            Text(pregunta.respuesta ?? "Respuesta")
                                            
                                        }label: {
                                            Text(pregunta.pregunta ?? "Pregunta")
                                                .fontWeight(.semibold)
                                            
                                        }
                                    }
                                }
                            }
                        }
                    }
                }.padding(.top,-70)
                
            }
            
        }
    }
}
