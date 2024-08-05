//
//  UITextFieldExtension.swift
//  AssignmentRegister
//
//  Created by Apple on 07/06/24.
//

import Foundation
import UIKit


extension UITextField{
    func setLeftImage(Imagename: String){
        let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: 20 , height: 20))
        imageView.image = UIImage(named: Imagename)
        let imageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 55 , height: 40))
        imageViewContainer.addSubview(imageView)
        leftView = imageViewContainer
        leftViewMode = .always
        self.tintColor = .lightGray
    }
}
