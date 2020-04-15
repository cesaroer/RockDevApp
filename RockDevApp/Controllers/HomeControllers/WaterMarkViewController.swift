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
        //Esta variable es para saber donde vamos a colocar el texto en la imagen
        let textPointOnImage = CGPoint(x: 30, y: 800)
        
        print("Contenido de txtfld: \(waterTextFld.text!)")
        
        //Verificamos que haya texto en el textfield
        if waterTextFld.text != nil && waterTextFld.text != ""{
            
            let text = waterTextFld.text
            waterMarkedImageView.image = textToImage(drawText: text!, inImage: contentImageView.image!, atPoint: textPointOnImage)
        }else{
        //Si no hay texto desplegamos una alerta al usuario
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
        //Damos color y opacidad al texto
        let textColor = UIColor.yellow.withAlphaComponent(0.4)
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
