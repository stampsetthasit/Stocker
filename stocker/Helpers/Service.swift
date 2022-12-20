//
//  DatabaseManager.swift
//  stocker
//
//  Created by Setthasit Poosawat on 4/11/21.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import UIKit

class Service {
    static let db = Firestore.firestore()
    private let auth = Auth.auth()
    private let defaults = UserDefaults.standard
    static let shared = Service()
    static let currentUser = Auth.auth().currentUser?.uid
    static let defaults = UserDefaults.standard
    
    public func register(businessname:String,email:String,password:String,completion:@escaping(Result<Model,Error>) -> Void) {
        auth.createUser(withEmail: email, password: password) { [weak self] (authresult,error) in
            guard let strongSelf = self else {return}
            if let error = error {
                let authError = error as NSError
                //                print(authError)
                completion(.failure(authError))
            }
            else {
                var response = Model()
                print("authresult",authresult?.user.uid)
                let userid = authresult?.user.uid ?? ""
                Service.db.collection(Constants.FireStore.collectionUser).document(userid).setData([
                    "user_businessname": businessname,
                    "user_email": email,
                    //                    "uid": userid
                    //                    "user_password" : password
                ]){ err in
                    if let err = err {
                        print("Error writing document: \(err)")
                        let dbError = err as NSError
                        completion(.failure(dbError))
                    }
                    else {
                        print("Document successfully written!")
                        response.id = userid
                        response.email = email
                        response.businessname = businessname
                        response.password = password
                        completion(.success(response))
                    }
                }
            }
        }
    }
    
    public func createReport() {
        Service.db.collection(Constants.FireStore.collectionReport).document(Service.currentUser!).collection(Service.currentUser!).document("report").setData([
            "sold": "0",
            "income": "0",
            "profit": "0"
        ]) { (error) in
            if let error = error {
                print("Error report \(error)")
            }
            else {
                print("Successfully report")
            }
        }
    }
    
    public func login(email:String,password:String,completion:@escaping(Result<Model,Error>) -> Void) {
        auth.signIn(withEmail: email, password: password) { (authresult,error) in
            if let error = error {
                let authError = error as NSError
                completion(.failure(authError))
            }
            else {
                var response = Model()
                response.email = email
                completion(.success(response))
            }
        }
    }
    
    public func reset(email: String, completion: @escaping(Result<Model,Error>) -> Void) {
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                let authError = error as NSError
                completion(.failure(authError))
            }
            else {
                var response = Model()
                response.email = email
                completion(.success(response))
            }
        }
    }
    
    public func getBusinessName(onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        Service.db.collection(Constants.FireStore.collectionUser).document(Service.currentUser!).addSnapshotListener { document, error in
            guard let document = document, document.exists else {
                print("Document does not exist")
                onError(error)
                return
            }
            if let buname = document.data()!["user_businessname"] as? String{
                let name = buname
                //                print("name\(name)")
                self.defaults.set(name, forKey: "businessname")
                
                onSuccess()
            }
        }
        
    }
    
    public func addItems(name: String, category: String, stock: String, price: String) {
        if (Service.currentUser) != nil {
            Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).document(name).setData([
                "product_name": name,
                "product_category": category,
                "product_inStock": stock,
                "product_price": price,
                "sold": "0"
            ]) { (error) in
                if let error = error {
                    print("Error adding document: \(error.localizedDescription)")
                }
                else {
                    print("Successfully saved data")
                }
            }
        }
    }
    
    public func editItems(name: String, stock: String, price: String) {
        if (Service.currentUser) != nil {
            Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).document(name).updateData([
                "product_name": name,
                "product_inStock": stock,
                "product_price": price
            ]) { (error) in
                if let error = error {
                    print("Error updating document: \(error.localizedDescription).")
                }
                else {
                    print("Successfully updated data.")
                }
            }
        }
    }
    
    public func deleteItem(name: String) {
        if Service.currentUser != nil {
            Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).document(name).delete { error in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription)")
                } else {
                    print("Document successfully removed!")
                }
            }
        }
    }
    
    public func getItems(tbView: UITableView) {
        Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).addSnapshotListener { querySnapshot, err in
            ProductView.itemsCell = []
            ShopView.items = []
            if let err = err {
                print("Error getting documents: \(err)")
            }
            else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    if let productName = data["product_name"] as? String, let productQuantity = data["product_inStock"] as? String, let productPrice = data["product_price"] as? String {
                        let newItem = Inventory.Categories.Products(item: productName, quantity: Int(productQuantity)!, price: Float(productPrice)!)
                        ProductView.itemsCell.append(newItem)
                        ShopView.items.append(newItem)
                        
                        DispatchQueue.main.async {
                            tbView.reloadData()
                        }
                        
                    }
                }
            }
            
        }
    }
    
    public func getCategory(tbView: UITableView) {
        Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).addSnapshotListener { document, err in
            CategoriesView.categoriesCell = []
            if let err = err {
                print("Error getting document: \(err)")
            }
            else {
                for document in document!.documents {
                    let data = document.data()
                    if let productCategory = data["product_category"] as? String, let productName = data["product_name"] as? String {
                        let newCategory = Inventory.Categories(category: "\(productCategory)", productName: "Item name: \(productName)")
                        CategoriesView.categoriesCell.append(newCategory)
                        DispatchQueue.main.async {
                            tbView.reloadData()
                        }
                        
                    }
                }
            }
        }
    }
    
    public func changePassword(newPassword: String, confirmPassword: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        if newPassword == confirmPassword {
            auth.currentUser?.updatePassword(to: "\(confirmPassword)", completion: { error in
                if let error = error {
                    onError(error)
                }
                else {
                    onSuccess()
                }
            })
        }
    }
    
    public func changeBusinessname(businessname: String, onSuccess: @escaping () -> Void, onError: @escaping (_ error: Error?) -> Void) {
        Service.db.collection(Constants.FireStore.collectionUser).document(Service.currentUser!).updateData(["user_businessname": businessname]) { error in
            if let error = error {
                onError(error)
            }
            else {
                onSuccess()
            }
        }
    }
    
    public func updateFromBasket(name: String, stock: String) {
        Service.db.collection(Constants.FireStore.collectionItem).document(Service.currentUser!).collection(Service.currentUser!).document(name).updateData(["product_inStock": stock]) { error in
            if let error = error {
                print("Error updating item in stock \(error.localizedDescription).")
            }
            else {
                print("Successfully update item in stock.")
            }
        }
    }
    
    public func checkUser(controller: UIViewController) {
        if auth.currentUser == nil {
            let welcomeView = controller.storyboard?.instantiateViewController(identifier: Constants.Storyboard.welcomeView) as? UINavigationController
            
            controller.view.window?.rootViewController = welcomeView
            controller.view.window?.makeKeyAndVisible()
        }
    }
    
    public func updateReport(sold: String, income: String, profit: String) {
        Service.db.collection(Constants.FireStore.collectionReport).document(Service.currentUser!).collection(Service.currentUser!).document("report").setData([
            "sold": sold,
            "income": income,
            "profit": profit
        ]) { (error) in
            if let error = error {
                print("Error report \(error)")
            }
            else {
                print("Successfully report")
            }
        }
    }
     
}
