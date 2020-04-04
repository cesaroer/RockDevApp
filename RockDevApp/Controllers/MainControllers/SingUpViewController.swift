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
        //sendUsrData(email: "lindsay.ferguson@reqres.in", pass: "asdfg")

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
        autocompleteUsrInfo()
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {
        let error = validarCampos()
        if error != nil{
            //Hubo un error en algun campo entonces mostramos mensaje de error
            showErrorMessage(error!)
        }else{
            sendUsrData(email: emailTextField.text!, pass: passwordTextField.text!)
        }
        
        
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
    
//MARK: Funcionpara mandar el registro del usuario a la API
    
    func sendUsrData(email: String, pass: String) {
        
        let urlString = "https://reqres.in/api/register"
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
                        self.showSuccesMessage("Registro Exítoso")
                        //Presentamos el HomeScreen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                            //transitionToHome(contview: self.view)
                            self.transitionToLogin()
                        }
                    }
                case .failure(let error):
                    print(error)
            }//END SC
        }//END Alamorife
    }//END sendUsrData
    
    
//MARK: Funcion de autocompletado de usuario
    
    func autocompleteUsrInfo(){
        nameTextField.text = "George"
        apellidoTextField.text = "Bluth"
        emailTextField.text = "george.bluth@reqres.in"
        passwordTextField.text = "Asdfghi1*"
    }
    
    
//MARK: Funcion de transision a LoginViewController

public func transitionToLogin(){
    
    //Instanciamos el homeVC
    let mainSB = UIStoryboard(name: "Main", bundle: nil)
    let loginViewController =  mainSB.instantiateViewController(identifier: "loginVC") as! LoginViewController
    
    //Presentamos la vista
    self.present(loginViewController, animated: true, completion: nil)
}
    


}

