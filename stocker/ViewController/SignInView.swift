//
//  signInView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 1/11/21.
//

import UIKit

class SignInView: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        //corner textField
        emailTF.layer.cornerRadius = emailTF.frame.size.height/2
        passwordTF.layer.cornerRadius = passwordTF.frame.size.height/2
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButton(_ sender: Any) {
        Service.shared.login(email: emailTF.text ?? "", password: passwordTF.text ?? "") { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    transitionToMainView(self: self!)
                case .failure(let error):
                    Alert.present(title: "Error", message: "\(error.localizedDescription)", from: self!)
                }
            }
        }
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "resetpassword") {
            //enable navigation for screen register
            navigationController?.setNavigationBarHidden(navigationController?.isNavigationBarHidden == false, animated: true)
        }
    }*/
}
