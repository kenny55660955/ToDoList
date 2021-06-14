//
//  CategoryTableTableViewController.swift
//  Todoey
//
//  Created by Kenny on 2021/6/14.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableTableViewController: UITableViewController {
    // MARK: - Property
    private var menuItems = [Menu]()
    
    private let context = AppDelegate().persistentContainer.viewContext
    
    private let request: NSFetchRequest<Menu> = Menu.fetchRequest()
    
    // MARK: - Lify Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadItems(with: request)
        
    }
    
    // MARK: - UI Methods
    @IBAction func addButtonPredded(_ sender: Any) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // What should happen when user clicks add item button
            
            let menuItem = Menu(context: self.context)
            
            menuItem.name = textField.text!
            menuItem.done = false
            
            self.menuItems.append(menuItem)
            
            self.setItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        let menuItem = menuItems[indexPath.row]
        
        cell.textLabel?.text = menuItems[indexPath.row].name
        
        //Ternary operator
        // Value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = menuItem.done == true ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        menuItems[indexPath.row].done = !menuItems[indexPath.row].done
        
        self.setItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Store Method
    // 儲存資料
    private func setItems() {
        do {
            try context.save()
        } catch {
            print("Error saving context \(error)" )
        }
        
        self.tableView.reloadData()
    }
    // 讀取資料
    private func loadItems(with request: NSFetchRequest<Menu>) {
        
        do {
            menuItems = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
    }
}
