//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Martevol on 1/27/19.
//  Copyright © 2019 Martevol. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categoryResult : Results<Category>?
        
    override func viewDidLoad() {
        super.viewDidLoad()

       loadCategory()
    }
    
    //MARK: - Tableview Datasource methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categoryResult?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CagetoryCell", for: indexPath)
        
        cell.textLabel?.text = categoryResult?[indexPath.row].name ?? "No Category Added Yet"
        
        return cell
    }
    
    //MARK: - Tableview Delegate methods
    
   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categoryResult?[indexPath.row]
        }
    }
    
    //MARK: - Add new category
    
   
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var cagetoryInput = UITextField()
        
        let alert = UIAlertController(title: "Add new category", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertTextField) in
            
            alertTextField.placeholder = "Create new category"
            cagetoryInput = alertTextField
        }
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newCategory = Category()
            
            newCategory.name = cagetoryInput.text!
            
            
            
            self.save(category: newCategory)
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil )
    
    }
    
    //MARK: - Data Manipulation Methods
    
    func save(category: Category) {
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error save category data \(error)")
        }
        
        tableView.reloadData()
    }
    
    func loadCategory() {
        
        categoryResult = realm.objects(Category.self)
        
        tableView.reloadData()
     
    }
    
    
}
