//
//  ValidateFuncions.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation

//Funcion que valida la contraseña
 func isPasswordValid(_ password : String) -> Bool {
    
    //Expresion regular con la que validaremos el formato de la contraseña
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
    
    
    return passwordTest.evaluate(with: password)
}
