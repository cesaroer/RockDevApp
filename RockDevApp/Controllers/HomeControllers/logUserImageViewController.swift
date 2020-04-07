//
//  logUserImageViewController.swift
//  RockDevApp
//
//  Created by Cesar on 06/04/20.
//  Copyright © 2020 CesarVargas. All rights reserved.
//

import UIKit

class logUserImageViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    @IBOutlet weak var saveImageView: UIImageView!
    @IBOutlet weak var fetchImageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
    

        // Do any additional setup after loading the view.
    }
    @IBAction func saveBtnPressed(_ sender: Any) {
        
        if let imageData = saveImageView.image?.pngData(){
            DataBaseHelper.shareInstance.saveImage(data: imageData)
        }
        
    }
    
    @IBAction func fetchImagePResedd(_ sender: Any) {
        
        let arr = DataBaseHelper.shareInstance.fetchImage()
        
        //fetchImageView.image = UIImage(data: arr[0].img!)
        if let imageData = arr.last?.img {
            fetchImageView.image = UIImage(data: imageData )
        }
    }
    
    @IBAction func cameraBtnPressed(_ sender: Any) {
        present(picker, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.editedImage] as? UIImage else{return}
        
        saveImageView.image = userPickedImage
        picker.dismiss(animated: true, completion: nil)
    }
    

}
