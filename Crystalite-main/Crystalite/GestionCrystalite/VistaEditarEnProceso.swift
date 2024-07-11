//
//  VistaEditarEnProceso.swift
//  Crystalite
//
//  Created by Aula11 on 28/12/22.
//

import SwiftUI

struct VistaEditarEnProceso: View {
    
    // Variables
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var vm: ViewModel
    @State var valorAl: Double = 0.0
    @State var valorBa: Double = 0.0
    @State var valorCa: Double = 0.0
    @State var valorIr: Double = 0.0
    @State var valorMg: Double = 0.0
    @State var valorK: Double = 0.0
    @State var nombreEnsayo: String = ""
    @State var ensayo: EnsayoEntity
    @State var resultado: String = ""
    @State var mostrarAlerta : Bool = false
    @State var valorAlerta : valorAlerta = .first
    
    var tipoCristal = ["Vidrio construccion flotado","Vidrio construccion no flotado","Vidrio contenedor","Vidrio Faro","Vidrio vajilla","Vidrio vehiculo flotado","Vidrio vehiculo no flotado"]
    @State var selectedItem = ""
    
    //View
    
    var body: some View {
        ZStack(alignment: .top){
            Color("Gris").ignoresSafeArea()
            
            VStack(){
                
                VStack(alignment: .leading) {
                    
                    Text("Ensayo en Proceso")
                        .font(.title).bold()
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    Spacer().frame(height: 15)
                    
#if Crystalite
                    Text("Nombre: ")
                        .font(.title2)
                        .foregroundColor(vm.modoOscuro ? .white : .black)
                    
                    TextField("Introducir nombre del ensayo", text: $nombreEnsayo)
                        .padding(.leading,20)
                        .frame(width: 300, height: 34)
                        .background(vm.modoOscuro ? .black.opacity(0.55) : .white)
                        .cornerRadius(10)
#endif
                    
#if CrystaliteEasy
                    Spacer().frame(height: 15)
                    
                    HStack{
                        Text("Nombre: ")
                            .fontWeight(.semibold)
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                            .padding(.leading,15)
                        
                        Spacer().frame(width:50)
                        
                        TextField("Introducir nombre...", text: $nombreEnsayo)
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                        
                    }
                    .frame(width: 300, height: 34)
                    .background(vm.modoOscuro ? .black.opacity(0.55) : .white)
                    .cornerRadius(10)
                    
                    HStack{
                        Text("Tipo Cristal: ")
                            .fontWeight(.semibold)
                            .foregroundColor(vm.modoOscuro ? .white : .black)
                            .padding(.leading,10)
                        
                        Spacer().frame(width: 20)
                        
                        Picker("Selecciona un cristal", selection: $selectedItem) {
                            ForEach(tipoCristal, id: \.self) {
                                Text($0)
                            }
                            
                        }
                        .frame(width: 150, height: 30,alignment: .leading)
                        .padding(.leading,10)
                        .background(.gray.opacity(0.25))
                        .cornerRadius(10)
                        
                        
                    }
                    .frame(width:300, height: 34)
                    .background(vm.modoOscuro ? .black.opacity(0.55) : .white)
                    .cornerRadius(10)
                    
                    
#endif
                    
                }
                
                Spacer().frame(height: 20)
                
                
                ScrollView{
                    ForEach(vm.elementoArray){
                        elementos in
                        ElementoView(elemento: elementos)
                    }
                }
                
                Button(){
                    
                    valorAl = vm.elementoArray[0].valor
                    valorBa = vm.elementoArray[1].valor
                    valorCa = vm.elementoArray[2].valor
                    valorIr = vm.elementoArray[3].valor
                    valorMg = vm.elementoArray[4].valor
                    valorK = vm.elementoArray[5].valor
                    
                    
                    
                    if(valorAl == 0.0 || valorBa == 0.0 || valorCa == 0.0 || valorIr == 0.0 || valorK == 0.0 || valorMg == 0.0){
                        vm.editEnsayoEnProceso(ensayo: ensayo, nombrenuevo: nombreEnsayo, enProceso: true,
                                               resultado: "En proceso", al: valorAl, ba: valorBa, ca: valorCa, ir: valorIr, k: valorK, mg: valorMg,creador : vm.personaLogin.nombre ?? "")
                        
                        self.valorAlerta = .first
                        self.mostrarAlerta = true
                        presentationMode.wrappedValue.dismiss()
                    }else{
                        resultado = calcularResultado(al: valorAl, ba: valorBa, ca: valorCa, ir: valorIr, k: valorK, mg: valorMg)
                        vm.editEnsayoEnProceso(ensayo: ensayo, nombrenuevo: nombreEnsayo, enProceso: false,
                                               resultado: resultado, al: valorAl, ba: valorBa, ca: valorCa, ir: valorIr, k: valorK, mg: valorMg,creador : vm.personaLogin.nombre ?? "")
                        
                        self.valorAlerta = .second
                        self.mostrarAlerta = true
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    
                }label: {
                    Text("Clasificar cristal")
                        .frame(width: 245, height: 59)
                        .background(vm.modoOscuro ? .black :Color("Azul"))
                        .tint(vm.modoOscuro ? .white : .black)
                        .clipShape(RoundedRectangle (cornerRadius: 19))
                        .padding(.all, 15)
                        .labelStyle(TitleOnlyLabelStyle())
                }.alert(isPresented: $mostrarAlerta) {
                    switch valorAlerta {
                    case .first:
                        return Alert(title: Text("Ensayo en proceso"), message: Text("Faltan datos por introducir"), dismissButton: .default(Text("Aceptar")))
                    case .second:
                        return Alert(title: Text("Cristal encontrado"), message: Text("Se ha calculado el resultado correctamente"), dismissButton: .default(Text("Aceptar")))
                    }
                }
            }.padding(.top,50)
            
        }.onAppear(){
            nombreEnsayo = ensayo.nombre ?? ""
            vm.elementoArray[0].valor = ensayo.al
            vm.elementoArray[1].valor = ensayo.ba
            vm.elementoArray[2].valor = ensayo.ca
            vm.elementoArray[3].valor = ensayo.ir
            vm.elementoArray[4].valor = ensayo.mg
            vm.elementoArray[5].valor = ensayo.k
        }.padding(.top,-95)
            .onDisappear(){
                vm.elementoArray[0].valor = 0
                vm.elementoArray[1].valor = 0
                vm.elementoArray[2].valor = 0
                vm.elementoArray[3].valor = 0
                vm.elementoArray[4].valor = 0
                vm.elementoArray[5].valor = 0
            }
    }
}

