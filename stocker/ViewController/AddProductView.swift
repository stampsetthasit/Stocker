//
//  addView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 14/11/2564 BE.
//

import UIKit

class AddProductView: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var inStock: UITextField!
    @IBOutlet weak var price: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //corner textField
        name.layer.cornerRadius = name.frame.size.height/2
        category.layer.cornerRadius = category.frame.size.height/2
        inStock.layer.cornerRadius = inStock.frame.size.height/2
        price.layer.cornerRadius = price.frame.size.height/2
        
        name.clipsToBounds = true
        category.clipsToBounds = true
        inStock.clipsToBounds = true
        price.clipsToBounds = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let err = validateField()
        if err != nil {
            Alert.present(title: "Error", message: "\(err!)", from: self)
        }
        else {
            Service.shared.addItems(name: name.text ?? "", category: category.text ?? "", stock: inStock.text ?? "", price: price.text ?? "")
            self.navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func validateField() -> String? {
        //Check that all fields are filled in
        if name.text ==  "" || inStock.text == "" || price.text == "" {
            return "Please fill in all fields."
        }
        else {
            if category.text == "" {
                category.text = "No Category"
            }
            return nil
        }
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
