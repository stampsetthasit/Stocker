//
//  homeView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var businessname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Service.shared.getBusinessName {
            self.businessname.text = "\(Service.defaults.string(forKey: "businessname")!)"
        } onError: { error in
            self.businessname.text = "Stocker App"
        }
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
    
    override func viewDidAppear(_ animated: Bool) {
        Service.shared.checkUser(controller: self)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
