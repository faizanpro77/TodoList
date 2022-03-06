//
//  ViewController.swift
//  TodoList
//
//  Created by Yashom on 05/03/22.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   // let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
       // searchBar.delegate = self

        loadItems()
    }
    
    //Mark - TableView Datasource Methods
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        2
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //print("cellForRowAt......1")
       // let cell = UITableViewCell(style: .default, reuseIdentifier: "ToDoItemCell")
        let cell = tableView.dequeueReusableCell(withIdentifier:"ToDoItemCell",
            for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title //+ " - IndexPath -> row \(indexPath.row) section \(indexPath.section)"
        
        //Ternary operator ==>
        //value = conditionn ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Section \(section)"
//    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
       // itemArray[indexPath.row].setValue("completed", forKey: title)
        
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        saveItems()
        
        //tableView.reloadData()
        
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        //after selecting highlight label (disable selection gray colour)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - ADD NEW ITEMS
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happend once user clicks the Add Item button on our UIAlert
            //print("Success!")
           // print(textField.text)

            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false

            self.itemArray.append(newItem)

            self.saveItems()

           // self.defaults.set(self.itemArray, forKey: "TodoListArray")

                    }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            //print(alertTextField.text)
            textField = alertTextField
        }

        alert.addAction(action)

        present(alert, animated: true, completion: nil)
    }
    
    //Mark - model manupulation Method
    
    func saveItems() {
        
        do {
          try context.save()
        } catch {
            print("Error saving context \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems(with request:NSFetchRequest<Item> = Item.fetchRequest()) {
        //let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
        itemArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }
    
    
}

//MARK:- Search bar methods
extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       // print(searchBar.text)
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        
        
        let sortDescriptor = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
                
        }
    }
    
}
