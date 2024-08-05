//
//  StringExtension.swift
//  AssignmentRegister
//
//  Created by Apple on 07/06/24.
//

import Foundation
import UIKit


extension String{
    var isPhoneNumber : Bool {
        if self.count < 10 {
            return false
        }
        return !(self.isEmpty) && self.allSatisfy { $0.isNumber }
        
    }
    var isValidEmail : Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    var isValidPassword : Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: self)
    }
    var isValidName : Bool {
        if self.count < 3{
            return false
        }
        return self.allSatisfy{$0.isLetter}
    }
    
}
