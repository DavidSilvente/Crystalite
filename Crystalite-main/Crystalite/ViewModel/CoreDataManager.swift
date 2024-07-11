//
//  CoreDataManager.swift
//  Crystalite
//
//  Created by Aula11 on 18/11/22.
//

import Foundation
import CoreData

class CoreDataManager{
    
    static let instance = CoreDataManager()
    let contenedor: NSPersistentContainer
    let contexto: NSManagedObjectContext
    
    init(){
        contenedor = NSPersistentContainer(name:"CrystaliteModel")
        contenedor.loadPersistentStores{(descripcion, error) in
            if let error = error{
                print("Error al cargar datos de CoreData: \(error)")
            }else{
                print("Carga de datos correcta")
            }
        }
        contexto = contenedor.viewContext
    }
    
    func save(){
        do{
            try contexto.save()
            print("Datos alamcenados correctamente")
        }catch let error{
            print("Error al guardar datos\(error)")
        }
    }
}
