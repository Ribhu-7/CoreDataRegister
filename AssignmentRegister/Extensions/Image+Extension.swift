//
//  Image+Extension.swift
//  AssignmentRegister
//
//  Created by Apple on 05/08/24.
//

import Foundation
import UIKit

extension UIImageView {
    func circleImage(){
        self.layer.borderWidth = 1
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
}
