//
//  ViewController.swift
//  stocker
//
//  Created by Setthasit Poosawat on 20/10/21.
//

import UIKit

class WelcomeView: UIViewController {
    
    @IBOutlet weak var signInBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        signInBtnOutlet.layer.borderColor = UIColor.init(red: 245/255, green: 13/255, blue: 86/255, alpha: 1).cgColor
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
}
