//
//  ViewController.swift
//  AssignmentRegister
//
//  Created by Apple on 05/06/24.
//

import UIKit
import PhotosUI

enum educationList: String, CaseIterable{
    case pg = "Post Graduate"
    case grad = "Graduate"
    case hsc = "HSC/Diploma"
    case ssc = "SSC"
}

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var profileImgView: UIImageView!
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var confpassTxt: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var education: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    private var pickerView: UIPickerView = {
        var picker = UIPickerView()
        return picker
    }()
    
    let datePicker = UIDatePicker()
    
    private lazy var toolBar: UIToolbar = {
        var toolbar = UIToolbar()
        let cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,target: self, action: #selector(cancel(_:)))
        let doneBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,target: self, action: #selector(done(_:)))
        
        toolbar.items = [cancelBarButtonItem, doneBarButtonItem]
        toolbar.barStyle = .default
        toolbar.sizeToFit()
        
        
        return toolbar
    }()
    
    var user: UserEntity?
    let manager = DatabaseManager()
    var imageSelectedByUser: Bool = false
    var genderVal: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setting icons on textfields
        firstName.setLeftImage(Imagename: "user")
        lastName.setLeftImage(Imagename: "user")
        phoneNumber.setLeftImage(Imagename: "phone")
        emailTxt.setLeftImage(Imagename: "email")
        passTxt.setLeftImage(Imagename: "lock")
        confpassTxt.setLeftImage(Imagename: "lock")
        //setting radio buttons
        btnMale.setImage(UIImage.init(named: "radio1"), for: .normal)
        btnFemale.setImage(UIImage.init(named: "radio1"), for: .normal)
        btnMale.setImage(UIImage.init(named: "radio"), for: .selected)
        btnFemale.setImage(UIImage.init(named: "radio"), for: .selected)
        
        phoneNumber.keyboardType = .numberPad
        
        
        
        setUpPickerView()
        setUpTextField()
        createDatePicker()
        addGesture()
    }
    
    //creating date picker
    
    func createDatePicker(){
        datePicker.preferredDatePickerStyle = .wheels
        
        if let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) {
            datePicker.maximumDate = yesterdayDate
        }
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneTimePressed))
        toolbar.setItems([doneButton], animated: true)
        dateField.inputAccessoryView = toolbar
        dateField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    
    //timepicker done bar button
    @objc func doneTimePressed(){
        //formatter
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        dateField.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    private func setUpPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func setUpTextField() {
        education.delegate = self
        education.inputView = pickerView
        education.inputAccessoryView = toolBar
    }
    
    @objc func done(_ sender: UIBarButtonItem) {
        let row = pickerView.selectedRow(inComponent: 0)
        education.text = educationList.allCases[row].rawValue
        view.endEditing(true)
    }
    
    @objc func cancel(_ sender: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    @IBAction func btnSelect(_ sender: UIButton) {
        if sender === btnMale{
            btnMale.isSelected = true
            btnFemale.isSelected = false
            genderVal = "Male"
        } else if sender === btnFemale{
            btnFemale.isSelected = true
            btnMale.isSelected = false
            genderVal = "Female"
        }
    }
    
    //main submit button
    @IBAction func submitBtn(_ sender: UIButton) {
        
        if phoneNumber.text?.isPhoneNumber == false || emailTxt.text?.isValidEmail == false || passTxt.text?.isValidPassword == false || firstName.text?.isValidName == false || lastName.text?.isValidName == false || passTxt.text != confpassTxt.text || education.text?.isEmpty == true || dateField.text?.isEmpty == true{
            let alert = UIAlertController(title: nil,message: "Please fill valid details",preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default)
            {
                (action) in (self.dismiss(animated: true,completion: nil))
            }
            alert.addAction(action)
            self.present(alert,animated: true,completion: nil)
        } else{
            configuration()
            print("All valid")
        }
        
        
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.education {
            // Select the value in the picker from the text in the textField
            let row = educationList.allCases.firstIndex(where: { (edc) -> Bool in
                edc.rawValue == self.education.text
            })
    
            if let row = row {
                pickerView.selectRow(row, inComponent: 0, animated: true)
            }
        }
    }
}
