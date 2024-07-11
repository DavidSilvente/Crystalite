//
//  Funciones.swift
//  Crystalite
//
//  Created by Aula11 on 10/1/23.
//

import Foundation


func ObtenerValor(elemento: ElementoEntity, ensayo : EnsayoEntity) -> Double{
    
    if(elemento.iniciales == "Al") {return ensayo.al}
    else if(elemento.iniciales == "Ba"){return ensayo.ba}
    else if(elemento.iniciales == "Ca"){return ensayo.ca}
    else if(elemento.iniciales == "RI"){return ensayo.ir}
    else if(elemento.iniciales == "Mg"){return ensayo.mg}
    else{return ensayo.k}
    
    
}

func ponerFecha(fecha : Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/YY"
    return dateFormatter.string(from: fecha)
}

func ponerFechaPeq(fecha : Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM"
    return dateFormatter.string(from: fecha)
}

func comprobarValorElemento(elemento: ElementoEntity, valor: String, vm: ViewModel){
    // @EnvironmentObject var vm: ViewModel
    
    vm.editElemento(elemento: elemento, valorNuevo: Double(valor) ?? 1)
}

func calcularResultado(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    if(ba <= 0.27){
        if(mg <= 2.41){
            return LM_1(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
        }else{
            if(al <= 1.41){
                if(ir <= 1.5170){
                    return LM_2(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
                }else{
                    if(k <= 0.23){
                        return LM_3(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
                    }else{
                        return LM_4(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
                    }
                }
            }else{
                if(mg <= 3.45){
                    return LM_5(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
                }else{
                    return LM_6(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
                }
            }
        }
    }else{
        return LM_7(al: al, ba: ba, ca: ca, ir: ir, k: k, mg: mg)
    }
}

func LM_1(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = -145.54 + (ir * 90.16) + (mg * 1.32) + (al * -4.5) + (k * 0.78) + (ca * 0.06) + (ba * -9.19)
    let construccionNonfloat : Double = -786.27 + (ir * 519.68) + (mg * -0.4) + (al * -1.28) + (k * 0.8) + (ca * -0.11) + (ba * 8.25)
    let vehiculofloat : Double = 460.78 + (ir * -316.05) + (mg * 1.76) + (al * -2.75) + (k * -2.68) + (ca * 0.87)
    let vehiculoNonfloat : Double = -31.08 + (mg * 0.01)
    let contenedores : Double = 871.16 + (ir * -584.24) + (mg * -0.57) + (al * 4.56) + (k * 0.86) + (ca * 1.09) + (ba * 2.46)
    let vajilla : Double = -824.35 + (ir * 553.91) + (mg * -0.21) + (al * 4.65) + (k * -113.95) + (ca * -1.65) + (ba * -3.04)
    let faro : Double = -1444.01 + (ir * 966.12) + (mg * -0.84) + (al * 0.36) + (k * 1.46) + (ca * -2.49) + (ba * -7.47)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_2(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = 87436.25 + (ir * -57673.49) + (mg * -0.3) + (al * -3.22) + (k * 8.39) + (ca * -0.27) + (ba * -11.98)
    let construccionNonfloat : Double = -14792.07 + (ir * 9815.19) + (mg * 0.83) + (al * -67.56) + (k * -10.17) + (ca * -0.32) + (ba * -7.98)
    let vehiculofloat : Double = 6100.72 + (ir * -4073.23) + (mg * 1.52) + (al * 10.93) + (k * -3.71) + (ca * 7.25) + (ba * 1.81)
    let vehiculoNonfloat : Double = -51.65 + (mg * 0.01)
    let contenedores : Double = 17.53 + (ir * -38.05) + (mg * -1.25) + (al * 3.98) + (k * 0.49) + (ca * 0.46) + (ba * 2.46)
    let vajilla : Double = 154.89 + (ir * -118.9) + (mg * -0.21) + (al * 3.9) + (k * -112.96) + (ca * -0.54) + (ba * -3.04)
    let faro : Double = -3733.18 + (ir * 2457.43) + (mg * -6) + (al * 0.36) + (k * 29.99) + (ca * -1.31) + (ba * 1.62)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_3(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = 124.97 + (ir * -78.58) + (mg * 1.28) + (al * -3.05) + (k * -4.5) + (ca * -0.28) + (ba * -23.86)
    let construccionNonfloat : Double = -815.23 + (ir * 619.01) + (mg * -36.66) + (al * -3.17) + (k * 7.46) + (ca * -0.02) + (ba * -7.98)
    let vehiculofloat : Double = 1151 + (ir * -753.53) + (mg * 1.77) + (al * -4.44) + (k * -3.4) + (ca * -0.46) + (ba * 19.21)
    let vehiculoNonfloat : Double = -61.93 + (mg * 0.01)
    let contenedores : Double = 7.24 + (ir * -38.05) + (mg * -1.25) + (al * 3.98) + (k * 0.49) + (ca * 0.46) + (ba * 2.46)
    let vajilla : Double = 144.61 + (ir * -118.9) + (mg * -0.21) + (al * 3.9) + (k * -112.96) + (ca * -0.54) + (ba * -3.04)
    let faro : Double = -5209.15 + (ir * 3431.78) + (mg * -10.39) + (al * 0.36) + (k * 45.07) + (ca * -1.31) + (ba * 1.62)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_4(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = 728.29 + (ir * -459.52) + (mg * -5.69) + (al * 4.94) + (k * 5.37) + (ca * -1.98) + (ba * 2.64)
    let construccionNonfloat : Double = -1617.23 + (ir * 1054.98) + (mg * 5.41) + (al * -6.64) + (k * -11.03) + (ca * 1.43) + (ba * -22.61)
    let vehiculofloat : Double = 1245.5 + (ir * -827.3) + (mg * 0.61) + (al * -4.27) + (k * -11.8) + (ca * 0.83) + (ba * 13.29)
    let vehiculoNonfloat : Double = -61.93 + (mg * 0.01)
    let contenedores : Double = 7.24 + (ir * -38.05) + (mg * -1.25) + (al * 3.98) + (k * 0.49) + (ca * 0.46) + (ba * 2.46)
    let vajilla : Double = 144.61 + (ir * -118.9) + (mg * -0.21) + (al * 3.9) + (k * -112.96) + (ca * -0.54) + (ba * -3.04)
    let faro : Double = -9775.23 + (ir * 6415.58) + (mg * -14.54) + (al * 0.36) + (k * 132.96) + (ca * -1.31) + (ba * 1.62)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_5(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = 727.54 + (ir * -493.91) + (mg * 3.48) + (al * -4.86) + (k * -0.36) + (ca * 0.82) + (ba * -22.55)
    let construccionNonfloat : Double = 70.65 + (ir * 41.45) + (mg * -12.14) + (al * -19.31) + (k * -4.32) + (ca * -6.88) + (ba * 8.25)
    let vehiculofloat : Double = -275.01 + (ir * 58.48) + (mg * 16.96) + (al * 21.12) + (k * 1.37) + (ca * 11.22) + (ba * 1.81)
    let vehiculoNonfloat : Double = -51.65 + (mg * 0.01)
    let contenedores : Double = 17.53 + (ir * -38.05) + (mg * -1.25) + (al * 3.98) + (k * 0.49) + (ca * 0.46) + (ba * 2.46)
    let vajilla : Double = 154.89 + (ir * -118.9) + (mg * -0.21) + (al * 3.9) + (k * -112.96) + (ca * -0.54) + (ba * -3.04)
    let faro : Double = -2820.83 + (ir * 1845.88) + (mg * -1.05) + (al * 0.36) + (k * 13.17) + (ca * -1.31) + (ba * 1.62)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_6(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = 1312.41 + (ir * -880.94) + (mg * -0.29) + (al * -4.62) + (k * -1.24) + (ca * 4.07) + (ba * -37.59)
    let construccionNonfloat : Double = -624.35 + (ir * 431.01) + (mg * 2.29) + (al * -4.14) + (k * 4.5) + (ca * -3.9) + (ba * 23.09)
    let vehiculofloat : Double = 37.03 + (ir * -85.69) + (mg * 4.76) + (al * 5.66) + (k * -3.1) + (ca * 6.83) + (ba * 1.81)
    let vehiculoNonfloat : Double = -51.65 + (mg * 0.01)
    let contenedores : Double = 17.53 + (ir * -38.05) + (mg * -1.25) + (al * 3.98) + (k * 0.49) + (ca * 0.46) + (ba * 2.46)
    let vajilla : Double = 154.89 + (ir * -118.9) + (mg * -0.21) + (al * 3.9) + (k * -112.96) + (ca * -0.54) + (ba * -3.04)
    let faro : Double = -2820.83 + (ir * 1845.88) + (mg * -1.05) + (al * 0.36) + (k * 13.17) + (ca * -1.31) + (ba * 1.62)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}

func LM_7(al:Double, ba:Double, ca: Double, ir: Double, k: Double, mg:Double) -> String{
    
    var resultados : [Double] = []
    let construccionfloat : Double = -103.78 + (ir * 90.07) + (mg * 3.08) + (al * -19.31) + (k * 0.3) + (ba * -11.22)
    let construccionNonfloat : Double = -276.97 + (ir * 158.76) + (mg * 0.28) + (al * -0.38) + (k * 0.47) + (ca * 2.43) + (ba * 4.83)
    let vehiculofloat : Double = 195.39 + (ir * -137.22) + (mg * 1.1) + (al * -2.5) + (k * -1.77) + (ca * 0.34)
    let vehiculoNonfloat : Double = -20.79 + (mg * 0.01)
    let contenedores : Double = -54.49 + (mg * -0.67) + (al * 15.15) + (k * 3.08) + (ca * 0.37) + (ba * 4.04)
    let vajilla : Double = 14.85 + (ir * -118.9) + (mg * -0.32) + (k * -22.56) + (ca * -0.22) + (ba * -3.04)
    let faro : Double = 121.08 + (ir * -66.07) + (mg * -2.54) + (al * -1.06) + (ca * -0.9) + (ba * -1.17)
    
    resultados.append(construccionfloat)
    resultados.append(construccionNonfloat)
    resultados.append(vehiculofloat)
    resultados.append(vehiculoNonfloat)
    resultados.append(contenedores)
    resultados.append(vajilla)
    resultados.append(faro)
    
    if(resultados.max() == construccionfloat){
        return "Vidrio construccion flotado"
    }else if(resultados.max() == construccionNonfloat){
        return "Vidrio construccion no flotado"
    }else if(resultados.max() == vehiculofloat){
        return "Vidrio vehiculo flotado"
    }else if(resultados.max() == vehiculoNonfloat){
        return "Vidrio vehiculo no flotado"
    }else if(resultados.max() == contenedores){
        return "Vidrio contenedor"
    }else if(resultados.max() == vajilla){
        return "Vidrio vajilla"
    }else{
        return "Vidrio faro"
    }
    
}
