//
//  ViewController.swift
//  RockDevApp
//
//  Created by Cesar on 03/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupElements()
        //Si hay session del usuario guardada entonces cargamos la vista principal de lo contrario nos quedamos en la vista predeterminada
        if UserDefaults.standard.bool(forKey: "isLogin") == true{
            print("Dirigiendo a Home")
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                 transitionToHome(contview: self.view)
            }
        }
            
    }

//MARK: Funcion que dará el estílo a nuestros botones
    func setupElements(){
       
        //Aplicamos los estilos a el boton
        Styles.styleFilledButton(signupButton)
        Styles.styleHollowButton(loginButton)
    }


}

