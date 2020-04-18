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
    case route
    case profile
    case waterMark
    case graphics
    case logout

}

class MenuViewController: UITableViewController {
    @IBOutlet weak var loggedUsrLbl: UILabel!
    @IBOutlet weak var usrFetchImageView: UIImageView!
    
    var didTapMenuType: ((MenuType) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        //El email del usuario es el que tenemos guardado
        loggedUsrLbl.text = UserDefaults.standard.string(forKey: "email")
        //SI hay imagen Guardada la cargamos, de lo contrario no hacemos nada
        let arr = DataBaseHelper.shareInstance.fetchImage()
        //fetchImageView.image = UIImage(data: arr[0].img!)
        if let imageData = arr.last?.img {
            usrFetchImageView.image = UIImage(data: imageData )
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //si la celda seleccionada es profile hacemos lo siguiente
        if indexPath.row == 2 {
            
            performSegue(withIdentifier: "imageSegue", sender: Any?.self)
            
        } else if indexPath.row == 3{
            
            performSegue(withIdentifier: "waterM", sender: Any?.self)
            
        } else if indexPath.row == 4{
            
            performSegue(withIdentifier: "chart", sender: Any?.self)
            
        } else{
            guard let menuType = MenuType(rawValue: indexPath.row) else {return}
            //Dependiendo la row que toquemos el enum nos lleva a una accion en otro controller o a cerrar session.
            dismiss(animated: true) { [weak self] in
                self?.didTapMenuType?(menuType)
            }
        }
    }
    


}
