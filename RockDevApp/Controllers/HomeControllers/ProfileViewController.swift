//
//  ProfileViewController.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit
import Alamofire

class ProfileViewController: UIViewController {

    @IBOutlet var usrImageView: UIImageView!
    @IBOutlet var usrNameLbl: UILabel!
    @IBOutlet var usrEmaillabl: UILabel!
    @IBOutlet var companyLbl: UILabel!
    @IBOutlet var urlCmpnyLbl: UILabel!
    @IBOutlet var sloganLbl: UILabel!
    @IBOutlet var usrIdLbl: UILabel!
    
    var usrImage : UIImage?
    var name = ""
    var lastName = ""
    var email = ""
    var usrId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usrImageView.image = usrImage!
        usrNameLbl.text = "\(name) \(lastName)"
        usrEmaillabl.text = email
        usrIdLbl.text = String(usrId)
        
        usrImageView.layer.masksToBounds = true
        usrImageView.layer.borderWidth = 3
        usrImageView.layer.borderColor = CGColor(srgbRed: 0, green: 0, blue: 0, alpha: 1)
        usrImageView.layer.cornerRadius = usrImageView.frame.width / 2
        
        getUsrCompleteData(id: usrId)
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
                    
                    DispatchQueue.main.async {
                         self.companyLbl.text = usrData?.ad?.company
                                           self.urlCmpnyLbl.text = usrData?.ad?.url
                                           self.sloganLbl.text = usrData?.ad?.text
                    }

                case .failure(let err):
                print(err)
            }
        }
    }


}
