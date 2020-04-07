//
//  DataBaseHelper.swift
//  RockDevApp
//
//  Created by Cesar on 06/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//MARK: Funcion para guardar la imagen en coreData
    func saveImage(data: Data){
        let imageInstance = Image(context: context)
        imageInstance.img = data
        
        do {
            try context.save()
            print("Imagen Guardada")
        } catch{
            print(error.localizedDescription)
        }
    }
    
//MARK: Funcion para obtener la imagen guardada
    
    func fetchImage() -> [Image]{
        var fetchingImage = [Image]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Image")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [Image]
        } catch {
            print("Error al obtener la imagen")
        }
        
        return fetchingImage
    }
    
}
