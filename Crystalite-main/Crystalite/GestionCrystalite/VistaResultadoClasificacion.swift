//
//  VistaResultadoClasificacion.swift
//  Crystalite
//
//  Created by Aula11 on 25/11/22.
//

import SwiftUI

struct VistaResultadoClasificacion: View {
    
    var body: some View {
        ZStack(alignment: .top){
            Color("Gris").ignoresSafeArea()
            
            VStack{
                Text("Resultado Clasifiaccion").font(.title);
                
                Spacer().frame(height: 30)
                elementoCristal(tipo: "Cristal Ventana", nombre: "Nombre Ensayo", fecha: "Fecha");
            
                Spacer().frame(height: 50)
                HStack{
                    Text("Variables usadas (6)");
                    Spacer().frame(width: 110);
                    
                    Button(){

                    }label: {
                        Image(systemName: "seal.fill")
                    }
                    
                }.frame(width: 300, alignment: .leading)
            
                //elementoResultadoFila(iniciales: "Mg", nombre: "Magnesio");
        }
    }
}
}

struct VistaResultadoClasificacion_Previews: PreviewProvider {
    static var previews: some View {
        VistaResultadoClasificacion()
    }
}
