//
//  HomeViewController.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var usrTableView: UITableView!
    //Variable que nos desplegará el numero de filas en la tabla
    var rows = 0
    //Estructura en la cual guardaremos los detalles de los usuarios
    var usrsData : [DatUsr]?
    var usrsAvatar: [UIImage] = []
    // variable que usaremos para guardar el indexpath seleccionado
    var iPathSelected = 0
    //Arreglos para guardar cosas a buscar
    var usersNamesArray: [String] = []
    var usersEmailsArray: [String] = []
    var usersIDArrays: [Int] = []
    var usersLastNameArray: [String] = []
    //Variables para buscar nombres de usuario
    var searchingNames = [String]()
    //Variable inicializada para animaciones
    let transition = SlideInTransition()
    var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usrTableView.delegate = self
        usrTableView.dataSource = self
        searchBar.delegate = self
        //Obtenemos los datos de los usuarios y los pintamos en la tabla
        getUsrList()

    }
    
//MARK: Actions Buttons
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        guard let menuVC = storyboard?.instantiateViewController(withIdentifier: "menuVc") as? MenuViewController else {return}
        menuVC.didTapMenuType = { menuType in
            self.loggout(menuType)
        }
        menuVC.modalPresentationStyle = .overCurrentContext
        menuVC.transitioningDelegate = self
        
        present(menuVC, animated: true)
        
    }
    
//MARK: Funcion de transicion a Vista inicial para Loggout
    func loggout(_ menuType: MenuType) {
        switch menuType {
            case .logout:
                //Borramos los datos de UserDefaults
                UserDefaults.standard.removeObject(forKey: "email")
                UserDefaults.standard.removeObject(forKey: "pass")
                UserDefaults.standard.set(false, forKey: "isLogin")
                transitionToMain(contview: view)
            case .profile:
                performSegue(withIdentifier: "profileSegue", sender: AnyObject.self)
            default:
                print("No hay esta opcion")
        }
    }
    
    
//MARK: Funciones getUser
    
    func getUsrList() {
        let urlString = "https://reqres.in/api/users"
        let urlToRequest = URL(string: urlString)!
        //Se crea el diccionario con parametros a enviar
        //Peticion Post
        AF.request(urlToRequest)
            .responseJSON { (response) in
            switch response.result {
                case .success:
                    print(" Respuesta a peticion GET: \(response.result)")
                    //Pasamos la respuesta de JSON a una Struct de neustro modelo
                    let decoder = JSONDecoder()
                    if let usrData = try? decoder.decode(GetUsers.self, from: response.data!){
                        //El numero de elementos que tenamos de la respuesta será el número de rows en la tabla
                        self.rows = usrData.data!.count
                        //Guardamos en nuestra variable global la respuesta
                        self.usrsData = usrData.data!
                        
                        //Guardamos los datos en los arreglos donde vamos a hacer las busquedas
                        for i in 0..<self.usrsData!.count{
                            self.usersNamesArray.append(self.usrsData![i].firstName!)
                            self.usersLastNameArray.append(self.usrsData![i].lastName!)
                            self.usersEmailsArray.append(self.usrsData![i].email!)
                            self.usersIDArrays.append(self.usrsData![i].id!)
                        }
                        
                        //Si hay imagen para el usuario guardamos la imagen en un arreglo local para evitar pedir la imagen al servidor cada vez que se tenga que desplegar.
                        for i in 0..<self.rows{
                            let imageUsrURL = URL(string: self.usrsData![i].avatar!)
                            print("Esta es la url: para \(i) : \(imageUsrURL!)")
                            if let imageUsrsData = try? Data(contentsOf: imageUsrURL!){
                                print("__Se  supone que si hay Data___")
                                if let imageUsr = UIImage(data: imageUsrsData){
                                    print("__Se  supone que si hay Imagen___")
                                    self.usrsAvatar.append(imageUsr)
                                }else{
                                    print("Entramos al else___NOOOOO")
                                    self.usrsAvatar.append(UIImage(named: "logo-serti")!)
                                }
                            }
                        }
                    }
                    //Recargamos la información en la tabla para poder visualizar los datos
                    DispatchQueue.main.async {
                        self.usrTableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
            }//END SC
        }//END Alamorife
    }
    
    
//MARK: Funcion para obtener los datos completos del usuario
    
    func getUsrCompleteData(id: Int) {
        let urlString = "https://reqres.in/api/users/\(id)"
        let urlToRequest = URL(string: urlString)!
        
        AF.request(urlToRequest).responseJSON { (response) in
            switch response.result {
                case .success:
                    let decoder = JSONDecoder()
                    let usrData = try? decoder.decode(UsrCompleteData.self, from: response.data!)
                case .failure(let err):
                print(err)
            }
        }
    }
    
    
//MARK: Funciones tableView
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        190
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching{
           return searchingNames.count
        }else{
           return self.rows
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usrCell", for: indexPath) as! UserTableViewCell
        cell.selectionStyle = .none
        
        //Si estamos buscando
        if searching {
            //cell.usrNameLbl.text = searchingNames[indexPath.row]
            let indexOfElement = usersNamesArray.firstIndex(of: searchingNames[indexPath.row])
            
            cell.usrIdLbl.text = String(usrsData![indexOfElement!].id!)
            cell.usrEmailLbl.text = usrsData![indexOfElement!].email!
            cell.usrNameLbl.text = usrsData![indexOfElement!].firstName!
            cell.usrApLbl.text = usrsData![indexOfElement!].lastName!
            //Se Asigna la imagen al imageView y se le da diseño redondeado
            cell.usrAvatarImageView.image = usrsAvatar[indexOfElement!]
            cell.usrAvatarImageView?.layer.masksToBounds = true
            cell.usrAvatarImageView?.layer.cornerRadius = cell.usrAvatarImageView.frame.width / 2
            cell.usrAvatarImageView?.layer.borderWidth = 3
            cell.usrAvatarImageView?.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
            
            
        }else{

        cell.usrIdLbl.text = String(usrsData![indexPath.row].id!)
        cell.usrEmailLbl.text = usrsData![indexPath.row].email!
        cell.usrNameLbl.text = usrsData![indexPath.row].firstName!
        cell.usrApLbl.text = usrsData![indexPath.row].lastName!
        //Se Asigna la imagen al imageView y se le da diseño redondeado
        cell.usrAvatarImageView.image = usrsAvatar[indexPath.row]
        cell.usrAvatarImageView?.layer.masksToBounds = true
        cell.usrAvatarImageView?.layer.cornerRadius = cell.usrAvatarImageView.frame.width / 2
        cell.usrAvatarImageView?.layer.borderWidth = 3
        cell.usrAvatarImageView?.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
            
        //Se añade bordes redondeados a lacelda
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 30
            
        

        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(usrsData![indexPath.row].firstName!)
        let storyBoardHome = UIStoryboard(name: "Home", bundle: nil)
        let profileVC = storyBoardHome.instantiateViewController(identifier: "profileVC") as! ProfileViewController
        DispatchQueue.main.async {
            profileVC.name = self.usrsData![indexPath.row].firstName!
            profileVC.lastName = self.usrsData![indexPath.row].lastName!
            profileVC.email = self.usrsData![indexPath.row].email!
            profileVC.usrId = self.usrsData![indexPath.row].id!
            profileVC.usrImage = self.usrsAvatar[indexPath.row]
            self.present(profileVC, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    //Animamos la entrada de las celdas
        let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 80, 0)
        cell.layer.transform = rotationTransform
        cell.alpha = 0.0
        
        UIView.animate(withDuration: 1.0) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate, UISearchBarDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    //Funciones de SearchBAr
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let usrNameSB = searchBar.text else {return}
        
        self.view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //Buscamos los nombres que coincidad incluso con introducir una letra
        searchingNames = self.usersNamesArray.filter({$0.prefix(searchText.count) == searchText})
        searching =  true
        usrTableView.reloadData()
    }
}
