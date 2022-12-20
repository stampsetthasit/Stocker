//
//  registerView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 1/11/21.
//

import UIKit

class RegisterView: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cfpasswordTF: UITextField!
    @IBOutlet weak var businessNameTF: UITextField!
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //corner textField
        emailTF.layer.cornerRadius = emailTF.frame.size.height/2
        passwordTF.layer.cornerRadius = passwordTF.frame.size.height/2
        cfpasswordTF.layer.cornerRadius = cfpasswordTF.frame.size.height/2
        businessNameTF.layer.cornerRadius = businessNameTF.frame.size.height/2
        
        emailTF.clipsToBounds = true
        passwordTF.clipsToBounds = true
        cfpasswordTF.clipsToBounds = true
        businessNameTF.clipsToBounds = true
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    func validateField() -> String? {
        //Check that all fields are filled in
        if emailTF.text ==  "" || passwordTF.text == "" || cfpasswordTF.text == "" || businessNameTF.text == "" {
            return "Please fill in all fields."
        }
        else if passwordTF.text != cfpasswordTF.text {
            return "Your password and confirmation password do not match."
        }
        else {
            return nil
        }
    }
    
    @IBAction func registerButton(_ sender: Any) {
        let err = validateField()
        if err != nil {
            Alert.present(title: "Error", message: "\(err!)", from: self)
        }
        else {
            Service.shared.register(businessname: businessNameTF.text ?? "", email: emailTF.text ?? "", password: cfpasswordTF.text ?? "") { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let user):
                        print("USER",user)
                        transitionToMainView(self: self!)
                    case .failure(let error):
                        Alert.present(title: "Error", message: "\(error.localizedDescription)", from: self!) //.localizedDescription
                    }
                }
            }
            Service.shared.createReport()
        }
    }
}
