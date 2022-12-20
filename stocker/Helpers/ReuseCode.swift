//
//  Reuse.swift
//  stocker
//
//  Created by Setthasit Poosawat on 5/11/21.
//

import Foundation
import UIKit

struct Alert {
    static func present(title: String?, message: String, from controller: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        // making a action button
        let closeAction = UIAlertAction(title: "Close", style: .default) { _ in
        }
        alertController.addAction(closeAction)
        
        // present the alert
        controller.present(alertController, animated: true, completion: nil)
    }
}

func transitionToMainView(self controller: UIViewController) {
    let mainView = controller.storyboard?.instantiateViewController(identifier: Constants.Storyboard.mainView) as? MainNavigationView
    
    controller.view.window?.rootViewController = mainView
    controller.view.window?.makeKeyAndVisible()
}

