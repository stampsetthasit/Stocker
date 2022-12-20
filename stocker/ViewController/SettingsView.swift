//
//  settingsView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit
import Firebase

class SettingsView: UIViewController {
    
    @IBOutlet weak var businessTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var cfpasswordTF: UITextField!
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //corner textField
        businessTF.layer.cornerRadius = businessTF.frame.size.height/2
        passwordTF.layer.cornerRadius = passwordTF.frame.size.height/2
        cfpasswordTF.layer.cornerRadius = cfpasswordTF.frame.size.height/2
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveSetting(_ sender: UIButton) {
        if businessTF.text != "" {
            Service.shared.changeBusinessname(businessname: businessTF.text!) {
                Alert.present(title: "Successfully", message: "Your password has been changed to \(self.businessTF.text!).", from: self)
            } onError: { error in
                Alert.present(title: "Error", message: "\(error!.localizedDescription)", from: self)
            }

        }
        else if passwordTF.text != "" && cfpasswordTF.text != "" {
            Service.shared.changePassword(newPassword: passwordTF.text!, confirmPassword: cfpasswordTF.text!) {
                Alert.present(title: "Successfully", message: "Your password has been changed.", from: self)
                self.passwordTF.text = ""
                self.cfpasswordTF.text = ""
            } onError: { error in
                Alert.present(title: "Error", message: "\(error!.localizedDescription)", from: self)
            }
        }
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        logOut()
    }
    
    func logOut() {
        do {
            try! Auth.auth().signOut()
            if let storyboard = self.storyboard {
                let vc = storyboard.instantiateViewController(withIdentifier: "welcomeVC") as! UINavigationController
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
        catch let err {
            Alert.present(title: "Error", message: "\(err.localizedDescription)", from: self)
        }
    }
}
