//
//  ChangeView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 23/11/2564 BE.
//

import UIKit

class ChangeView: UIViewController {
    
    @IBOutlet weak var changeLabel: UILabel!
    
    var change:Float = 0.0

    @IBAction func doneButton(_ sender: Any) {
        transitionToMainView(self: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        changeLabel.isHidden = false
        changeLabel.text = String(format: "%.2f", change)+" THB"
        super.viewDidAppear(animated)
        changeLabel.center.x = view.center.x // Place it in the center x of the view.
        changeLabel.center.x -= view.bounds.width // Place it on the left of the view with the width = the bounds'width of the view.
        // animate it from the left to the right
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn], animations: {
            self.changeLabel.center.x += self.view.bounds.width
              self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        changeLabel.isHidden = true

        // Do any additional setup after loading the view.
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
