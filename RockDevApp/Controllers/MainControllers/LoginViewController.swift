//
//  LoginViewController.swift
//  RockDevApp
//
//  Created by Cesar on 03/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import Alamofire

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
        
        //Limpiamos los textfields
        
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        sendUsrData(email: email, pass: password)
        
    }
    
    @IBAction func autoCompletBtnTapped(_ sender: Any) {
        autocompleteUsrInfo()
    }
    
//Función que muestra el label con un mensaje de error
    func showErrorMessage(_ message: String){
            errorLabel.text = message
            errorLabel.textColor = .red
            errorLabel.alpha = 1
    }
    
//Funcion para mostrar mensaje exítoso
    func showSuccesMessage(_ message: String){
        errorLabel.text = message
        errorLabel.textColor = .green
        errorLabel.alpha = 1
    }
    

//MARK: Funcionpara mandar el Login con info del usuario a la API

    func sendUsrData(email: String, pass: String) {
           
           let urlString = "https://reqres.in/api/login"
           let urlToRequest = URL(string: urlString)!
           //Se crea el diccionario con parametros a enviar
           let dictionaryToSend = [
               "email" : email,
               "password": pass
           ]
           //Peticion Post
           AF.request(urlToRequest, method: .post, parameters: dictionaryToSend , encoding: JSONEncoding.default)
               .responseJSON { (response) in
               switch response.result {
                   case .success:
                       print(" Respuesta a peticion POST: \(response.result)")
                       //Guardamos la respuesta en una estructura ajustada a Codable
                       //Verificamos que no haya un BadRequest
                       let decoder = JSONDecoder()
                       let posibleErrorResponse = try? decoder.decode(ErrorRequest.self, from: response.data!)
                       if let errorMessaje = posibleErrorResponse!.error {
                           self.showErrorMessage(errorMessaje)
                       }else{
                           //En caso de no tener error verificamos la respuesta
                           let postResponse = try? decoder.decode(PostUsrRequest.self, from: response.data!)
                           print(postResponse!)
                           self.showSuccesMessage("Verificado")
                        
                            //Guardamos el correo y contraseña en UserDEfaults
                            UserDefaults.standard.set(email, forKey: "email")
                            UserDefaults.standard.set(pass, forKey: "pass")
                            UserDefaults.standard.set(true, forKey: "isLogin")
                            UserDefaults.standard.synchronize()
                           //Presentamos el HomeScreen
                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                transitionToHome(contview: self.view)
                           }
                       }
                   case .failure(let error):
                       print(error)
               }//END SC
           }//END Alamorife
       }//END sendUsrData
    
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
