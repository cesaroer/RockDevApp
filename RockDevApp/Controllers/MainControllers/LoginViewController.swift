//
//  LoginViewController.swift
//  RockDevApp
//
//  Created by Cesar on 03/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

        @IBOutlet weak var emailTextField: UITextField!
        @IBOutlet weak var passwordTextField: UITextField!
        @IBOutlet weak var loginButton: UIButton!
        @IBOutlet weak var errorLabel: UILabel!

        override func viewDidLoad() {
            super.viewDidLoad()
            setupElements()
            //Funcion para ocultar el Teclado tocando en cualquier parte
            self.hideKeyboard()

        }
        
    //MARK: Buttons Actions

    @IBAction func loginTapped(_ sender: Any) {
        
        //Validamos los texfields
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
          || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            errorLabel.text =  "Por favor llena todos los campos"
            errorLabel.alpha = 1
        }
        

        
        
    }
        
        @IBAction func autoCompletBtnTapped(_ sender: Any) {
            autocompleteUsrInfo()

        }
    
    
    //MARK: Funcion para dar Estilo a la vista
    
    func setupElements(){
     
        //ocultamos el label de error mientras no haya uno
        errorLabel.alpha = 0
        //Aplicamos los estilos a los texfields
        Styles.styleTextField(emailTextField)
        Styles.styleTextField(passwordTextField)
        //Aplicamos los estilos a el boton
        Styles.styleFilledButton(loginButton)
     }

    //MARK: Funcion de autocompletado de usuario
    
    func autocompleteUsrInfo(){
        emailTextField.text = "george.bluth@reqres.in"
        passwordTextField.text = "Asdfghi1*"
    }
        
    


}
