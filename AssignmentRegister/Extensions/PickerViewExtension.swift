//
//  PickerViewExtension.swift
//  AssignmentRegister
//
//  Created by Apple on 07/06/24.
//

import Foundation
import UIKit

extension RegisterViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return educationList.allCases[row].rawValue
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return educationList.allCases.count
    }
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if textField == self.education {
//            // Select the value in the picker from the text in the textField
//            let row = educationList.allCases.firstIndex(where: { (edc) -> Bool in
//                edc.rawValue == self.education.text
//            })
//
//            if let row = row {
//                pickerView.selectRow(row, inComponent: 0, animated: true)
//            }
//        }
    }

