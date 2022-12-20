//
//  shopView.swift
//  stocker
//
//  Created by Setthasit Poosawat on 2/11/21.
//

import UIKit

class ShopView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var numOfItem: UIButton!
    @IBOutlet weak var totalOfItem: UILabel!
    @IBOutlet weak var basketView: UIView!
    
    static var items:[Inventory.Categories.Products] = []
    var basket:[Basket] = []
    var total:[Float] = []
    var payTotal:Float = 0.0
    var basketCount:Int = 0
    var flag:Bool = false
    
    @IBAction func clearBasket(_ sender: Any) {
        clearBasket()
    }
    
    @IBAction func chargeButton(_ sender: Any) {
        if basketCount != 0 {
            performSegue(withIdentifier: "PaymentVC", sender: self)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ShopView.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "items", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = ShopView.items[indexPath.row].item
        cell.textLabel?.textColor = #colorLiteral(red: 0.1176313534, green: 0.1176591739, blue: 0.1432597041, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateDatabase(name: ShopView.items[indexPath.row].item, quantity: ShopView.items[indexPath.row].quantity, price: ShopView.items[indexPath.row].price, sold: +1)
        updateBasket(name: ShopView.items[indexPath.row].item, price: ShopView.items[indexPath.row].price)
        calculate()
        basketOutlet()
    }
    
    override func viewDidLoad() {
        //Back Button
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        //Border Num of Item
        numOfItem.layer.borderColor = UIColor.white.cgColor
        Service.shared.getItems(tbView: self.tableView)
        clearBasket()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func updateDatabase(name: String, quantity: Int, price: Float, sold: Int) {
        let stock = quantity-1
        Service.shared.updateFromBasket(name: name, stock: String(stock))
    }
    
    func updateBasket(name: String, price: Float) {
        basketCount += 1
        let newItem = Basket(item: name, price: price)
        basket.append(newItem)
        total.append(newItem.price)
    }
    
    func calculate() {
        let totalprice = self.total.reduce(0, +)
        payTotal = totalprice
    }
    
    func basketOutlet() {
//        let totalprice = self.total.reduce(0, +)
        numOfItem.titleLabel?.text = "\(basketCount)"
        totalOfItem.text = String(format: "%.2f", payTotal)+" THB"
    }
    
    func clearBasket() {
        total = []
        basket = []
        basketCount = 0
        numOfItem.titleLabel?.text = "0"
        totalOfItem.text = "0.00 THB"
    }
    
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "PaymentVC" {
             let vc = segue.destination as! PaymentView
             vc.payTotal = payTotal
             vc.basket = basketCount
         }
     }

}
