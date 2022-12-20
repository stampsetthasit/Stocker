//
//  editSelectView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 14/11/2564 BE.
//

import UIKit

class EditProductView: UIViewController {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var inStock: UITextField!
    @IBOutlet weak var price: UITextField!
    
    var editingItem:[Inventory.Categories.Products] = []
    var editCategry:[Inventory.Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Corner radius
        name.layer.cornerRadius = name.frame.size.height/2
        inStock.layer.cornerRadius = inStock.frame.size.height/2
        price.layer.cornerRadius = price.frame.size.height/2
        
        initTF()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        let err = validateField()
        if err != nil {
            Alert.present(title: "Error", message: "\(err!)", from: self)
        }
        else {
            Service.shared.editItems(name: name.text ?? "", stock: inStock.text ?? "", price: price.text ?? "")
            dismissVC(controller: self)
        }
        
    }
    @IBAction func cancelButton(_ sender: Any) {
        dismissVC(controller: self)
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        let err = validateField()
        if err != nil {
            Alert.present(title: "Error", message: "\(err!)", from: self)
        }
        else {
            Service.shared.deleteItem(name: name.text ?? "")
            dismissVC(controller: self)
        }
    }
    
    func validateField() -> String? {
        //Check that all fields are filled in
        if name.text == "" {
            return "Product name is nil."
        }
        else if name.text ==  "" || inStock.text == "" || price.text == "" {
            return "Please fill in all fields."
        }
        return nil
    }
    
    func dismissVC(controller: UIViewController) {
        controller.navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    func initTF() {
        name.text = editingItem[0].item
        inStock.text = String(editingItem[0].quantity)
        price.text = String(format: "%.2f", editingItem[0].price)
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
