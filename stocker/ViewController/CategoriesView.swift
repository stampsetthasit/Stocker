//
//  categoriesView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit

class CategoriesView: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    static var categoriesCell:[Inventory.Categories] = [
//        Inventory.Categories(category: "Category A",productName: "Item 1"),
//        Inventory.Categories(category: "Category E",productName: "Item 2"),
//        Inventory.Categories(category: "Category Z",productName: "Item 3")
    ]
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent = false
        tableView.delegate = self
        tableView.dataSource = self
        Service.shared.getCategory(tbView: self.tableView)
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

extension CategoriesView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CategoriesView.categoriesCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = CategoriesView.categoriesCell[indexPath.row].category
        cell.detailTextLabel?.text = CategoriesView.categoriesCell[indexPath.row].productName
        
        return cell
    }
}
