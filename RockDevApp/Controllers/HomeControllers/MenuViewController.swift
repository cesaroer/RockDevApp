//
//  MenuViewController.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

enum MenuType: Int{
    case home
    case profile
    case logout
}

class MenuViewController: UITableViewController {
    @IBOutlet weak var loggedUsrLbl: UILabel!
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        //El email del usuario es el que tenemos guardado
        loggedUsrLbl.text = UserDefaults.standard.string(forKey: "email")

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else {return}
        //Dependiendo la row que toquemos el enum nos lleva a una accion en otro controller o a cerrar session.
        dismiss(animated: true) { [weak self] in
            self?.didTapMenuType?(menuType)
        }
    }
    


}
