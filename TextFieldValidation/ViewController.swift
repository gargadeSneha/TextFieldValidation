//
//  ViewController.swift
//  TextFieldValidation
//
//  Created by Sneha Gargade on 05/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var emailError: UILabel!
    
    @IBOutlet weak var passTF: UITextField!
    
    @IBOutlet weak var passError: UILabel!
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        emailError.isHidden = true
        passError.isHidden = true
      
        emailTF.delegate = self
        passTF.delegate = self
       
    }
    func isValidEmail(_ email: String, with regex: String) -> Bool {
           let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
           return emailPredicate.evaluate(with: email)
       }
    
    func isValidPassword(_ password: String, with regex: String) -> Bool {
          let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
          return passwordPredicate.evaluate(with: password)
      }
    
    func showErrorLabel(for errorLabel: UILabel, with message: String) {
         errorLabel.isHidden = false
         errorLabel.text = message
     }

     func hideErrorLabel(for errorLabel: UILabel) {
         errorLabel.isHidden = true
         errorLabel.text = ""
     }

    @IBAction func submitBtn(_ sender: UIButton) {

        // Validate email using regex
             let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

             if emailTF.text!.isEmpty {
//                 emailError.isHidden = false
//                 emailError.text = "Email cannot be empty"
                 showErrorLabel(for: emailError, with: "Email cannot be empty")
             } else if !isValidEmail(emailTF.text!, with: emailRegex) {
//                 emailError.isHidden = false
//                 emailError.text = "Invalid email format"
                 showErrorLabel(for: emailError, with: "Invalid email format")
             } else {
//                 emailError.isHidden = true
                 hideErrorLabel(for: emailError)
             }
        
        // Validate password using regex
        let passwordRegex = "^(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$"
             if passTF.text!.isEmpty {
                 showErrorLabel(for: passError, with: "Password cannot be empty")
             }else if !isValidPassword(passTF.text!, with: passwordRegex) {
                 showErrorLabel(for: passError, with: "Password must contain at least one number and one special character")
             } else {
                 hideErrorLabel(for: passError)
             }

             // Check if both text fields are not empty and email is valid
             if !emailTF.text!.isEmpty, isValidEmail(emailTF.text!, with: emailRegex), !passTF.text!.isEmpty {
                 // Perform further actions if needed
                 print("Validation passed. Email: \(emailTF.text!), Password: \(passTF.text!)")
             }
    }
}

extension ViewController: UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           // Validate email while typing
           if textField == emailTF {
               let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
               let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
               
               if !updatedText.isEmpty, !isValidEmail(updatedText, with: emailRegex) {
                   emailError.isHidden = false
                   emailError.text = "Invalid email format"
               } else {
                   emailError.isHidden = true
               }
           }
        
        // Validate password while typing
               if textField == passTF {
                   let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
                   let passwordRegex = "^(?=.*[0-9])(?=.*[^A-Za-z0-9]).{8,}$"
                   
                   if !updatedText.isEmpty, !isValidPassword(updatedText, with: passwordRegex) {
                       passError.isHidden = false
                       passError.text = "Password must contain at least one number and one special character"
                   } else {
                       passError.isHidden = true
                   }
               }

           return true
       }
}
