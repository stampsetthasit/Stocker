//
//  productView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit


class ProductView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var itemsCell:[Inventory.Categories.Products] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //Remove Blur Effect
        self.navigationController?.navigationBar.isTranslucent = false
        tableView.delegate = self
        tableView.dataSource = self
        Service.shared.getItems(tbView: self.tableView)
//        print("Items in cell\(itemsCell)")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ProductView.itemsCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath) as? InventoryCell
        cell?.itemName.text = ProductView.itemsCell[indexPath.row].item
        cell?.inStock.text = ProductView.itemsCell[indexPath.row].quantity.description
        cell?.price.text = ProductView.itemsCell[indexPath.row].price.description+" "+"฿"
        
        return cell!
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let rowData = self.tableView.indexPathForSelectedRow?.row
        if segue.identifier == "EditItemVC" {
            let vc = segue.destination as! EditProductView
            vc.editingItem.append(ProductView.itemsCell[rowData!])
        }
    }
    
}
