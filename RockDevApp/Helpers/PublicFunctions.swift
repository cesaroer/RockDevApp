//
//  PublicFunctions.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit


//MARK: Funcion de transision a HomeViewController

public func transitionToHome (contview: UIView){
    
    //Instanciamos el homeVC
    let homeSB = UIStoryboard(name: "Home", bundle: nil)
    let homeViewController =  homeSB.instantiateViewController(identifier: "homeVC") as? HomeViewController
    //Hacemos el HomeVC el rootVC ahora
    contview.window?.rootViewController = homeViewController
    contview.window?.makeKeyAndVisible()
}

//MARK: Funcion de transision a ViewInicial

public func transitionToMain (contview: UIView){
    
    //Instanciamos el homeVC
    let mainSB = UIStoryboard(name: "Main", bundle: nil)
    let mainViewController =  mainSB.instantiateViewController(identifier: "inicialVC")
    //Hacemos el HomeVC el rootVC ahora
    contview.window?.rootViewController = mainViewController
    contview.window?.makeKeyAndVisible()
}
