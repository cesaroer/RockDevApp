//
//  WaterMarkViewController.swift
//  RockDevApp
//
//  Created by Cesar on 14/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class WaterMarkViewController: UIViewController{
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var waterMarkedImageView: UIImageView!
    @IBOutlet weak var waterTextFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func beginBtnPressed(_ sender: Any) {
        
        let point = CGPoint(x: 20, y: 40)
        
        print("Contenido de txtfld: \(waterTextFld.text)")
        
        if waterTextFld.text != nil && waterTextFld.text != ""{
            
            let text = waterTextFld.text
            
            waterMarkedImageView.image = textToImage(drawText: text!, inImage: contentImageView.image!, atPoint: point)
        }else{
            let alert = UIAlertController(title: "Introduce un texto", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Entendido", style: .default) { (ok) in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }

        
    }
    
//MARK: Funcion para agregar texto como marca de agua
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
        let textColor = UIColor.yellow
        let textFont = UIFont(name: "Helvetica Bold", size: 100)!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        let rect = CGRect(origin: point, size: image.size)
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage!
    }
    
}
