//
//  RegisterVC+Extension.swift
//  AssignmentRegister
//
//  Created by Apple on 05/08/24.
//

import Foundation
import UIKit
import PhotosUI

extension RegisterViewController: PHPickerViewControllerDelegate {
    func configuration(){
        
        userDetailConfiguration()
    }
    
    func addGesture(){
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openGallery))
        self.profileImgView.addGestureRecognizer(imageTap)
    }
    
    func showAlert(){
        let alertController = UIAlertController(title: nil, message: "User added", preferredStyle: .alert)
              let okay = UIAlertAction(title: "Okay", style: .default)
              alertController.addAction(okay)
              present(alertController, animated: true)
    }
    
    func openAlert(message: String){
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            let okay = UIAlertAction(title: "Okay", style: .default)
            alertController.addAction(okay)
            present(alertController, animated: true)
        }
    
    func userDetailConfiguration(){
        if !imageSelectedByUser {
            openAlert(message: "Please select image")
            return
        }
        guard let firstName = firstName.text ,
              let lastName = lastName.text ,
              let phoneNumber = phoneNumber.text ,
              let password = passTxt.text ,
              let dob = dateField.text ,
              let education = education.text ,
              let email = emailTxt.text
        else{
            return
        }
        
        
        let imageName = UUID().uuidString
        let newUser = UserModel(firstName: firstName, lastName: lastName, email: email, password: password ,imageName: imageName , dob: dob , phoneNumber: phoneNumber , education: education , gender: genderVal)
        saveImagetoDocumentDirectory(imageName: imageName)
        manager.addUser(newUser)
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveImagetoDocumentDirectory(imageName: String){
        let fileURL = URL.documentsDirectory.appending(components: imageName).appendingPathExtension("png")
        if let data = profileImgView.image?.pngData() {
            do{
                try data.write(to: fileURL) //saving data in path
            } catch{
                print("Saving image to document directory error")
            }
        }
    }
    
    @objc func openGallery(){
        var config = PHPickerConfiguration()
        config.selectionLimit = 1 // 0 unlimited
        
        let pickerVC = PHPickerViewController(configuration: config)
        
        pickerVC.delegate = self
        present(pickerVC, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self){
                //load object uses background thread
                image,error in
                guard let image = image as? UIImage else {return}
                DispatchQueue.main.async {
                    self.profileImgView.image = image
                    self.imageSelectedByUser = true
                    self.profileImgView.circleImage()
                }
               
            }
        }
    }
    
    
}
