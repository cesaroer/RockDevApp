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


    }

   
    
//MARK: Buttuns Actions
    
    @IBAction func autocompleteBtnTapped(_ sender: Any) {
    }
    
    
    @IBAction func signUpBtnTapped(_ sender: Any) {

        
    }
   


}

