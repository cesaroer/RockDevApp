//
//  Colors.swift
//  RockDevApp
//
//  Created by Cesar on 04/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //Vamos a hacer nuestros propios colores
    
    public class var myGreen: UIColor{
        return UIColor(red: 46/255, green: 196/255, blue: 182/255, alpha: 1)
    }
    
    public class var myBlue: UIColor{
        return UIColor(red: 1/255, green: 22/255, blue: 39/255, alpha: 1)
    }
    
    //Tambien se puede de esta forma
    
    static var myWhite = UIColor(red: 253/255, green: 255/255, blue: 252/255, alpha: 1)
    
    static var myRed = UIColor(red: 239/255, green: 50/255, blue: 49/255, alpha: 1)
        
    
}
