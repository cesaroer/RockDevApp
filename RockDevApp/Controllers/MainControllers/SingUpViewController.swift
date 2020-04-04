//
//  SingUpViewController.swift
//  RockDevApp
//
//  Created by Cesar on 03/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//


import UIKit
import Alamofire

class SingUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var apellidoTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        //Funcion para ocultar el Teclado tocando en cualquier parte
        self.hideKeyboard()

    }
    
    //Verifica los campos y valida que los datos son correctos, si todo esta bien la funcion devuelve nil, en otro caso devuelve mensaje de error
      func validarCampos() -> String? {
              
              //Verificamos que los campos tienen datos
             
              if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                || apellidoTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
                || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
                  return "Por favor llena todos los campos"
              }
              
              //Verificar si la contraseña es segura
              //*Usamos trimmingCharacters(in: .whitespacesAndNewlines) para limpiar de espacios y saltos de linea la contraseña del usuario*
              let cleanPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
          if  isPasswordValid(cleanPassword) == false {
                  //La contraseña no es suficientemente segura
                  return "introduce una contraseña con: al menos 8 caracteres ,un caracter especial y un numero"
              }
              return nil
      }

   
    
//MARK: Buttuns Actions
    
    @IBAction func autocompleteBtnTapped(_ sender: Any) {
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {

        
    }

    func setupElements(){
        //ocultamos el label de error mientras no haya uno
        errorLabel.alpha = 0
        //Aplicamos los estilos a los texfields
        Styles.styleTextField(nameTextField)
        Styles.styleTextField(apellidoTextField)
        Styles.styleTextField(emailTextField)
        Styles.styleTextField(passwordTextField)
        //Aplicamos los estilos a el boton
        Styles.styleFilledButton(signUpButton)
    }


}

