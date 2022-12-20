//
//  paymentView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit

class PaymentView: UIViewController {

    @IBOutlet weak var amountTF: UITextField!
    @IBOutlet weak var amontLabel: UILabel!
    
    var payTotal:Float = 0.0
    var change:Float = 0.0
    var basket:Int = 0
       
    @IBAction func confirmButton(_ sender: Any) {
        paychange()
//        Service.shared.updateReport(sold: "\(basket)", income: "\(payTotal)", profit: "\(change+payTotal)")
        performSegue(withIdentifier: "ChangeVC", sender: self)
        clear()
    }
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        amontLabel.text = String(format: "%.2f", payTotal)
        amountTF.text = String(format: "%.2f", payTotal)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func paychange() {
        change = Float(amountTF.text!)! - payTotal
    }
    
    func clear() {
        payTotal = 0.0
        change = 0.0
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ChangeVC" {
            let vc = segue.destination as! ChangeView
            vc.change = change
        }
    }

}
