//
//  ExtensionVC.swift
//  SeaFoodML
//
//  Created by vitali on 12.07.2023.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            DispatchQueue.main.async {
                self.imageView.image = userPickedImage
            }
            
            // changing photo in imageCoreML
            guard let ciImage = CIImage(image: userPickedImage)  else{fatalError("can not convert")}
          //  self.navigationItem.title = ManagerModel.shared.detect(image: ciImage).id
            self.confidenceLabel.text = "confidence: \(ManagerModel.shared.detect(image: ciImage).confidence)%"
            self.nameLabel.text = "result: \(ManagerModel.shared.detect(image: ciImage).id)"
            
            //self.detect(image: ciImage)

        }
        imagePicker.dismiss(animated: true)
        
    }
    
}


extension ViewController: UINavigationControllerDelegate{
    
}
