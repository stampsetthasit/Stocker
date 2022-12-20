//
//  resetPasswordView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit

class ResetPasswordView: UIViewController {

    
    @IBOutlet weak var resetTF: UITextField!
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //corner textField
        resetTF.layer.cornerRadius = resetTF.frame.size.height/2
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func resetPasswordButton(_ sender: Any) {
        Service.shared.reset(email: resetTF.text ?? "") { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    Alert.present(title: "Error", message: "\(error.localizedDescription)", from: self!)
                case .success(let user):
                    print("user \(user)")
                    Alert.present(title: "Successful", message: "A password reset email has been sent!", from: self!)
                }
            }
        }

    }
    

}
