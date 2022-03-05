//
//  ViewController.swift
//  TodoList
//
//  Created by Yashom on 05/03/22.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

   // let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("faizan")
        print(dataFilePath)
        
        // Do any additional setup after loading the view.
        
//        let newItem = Item()
//        newItem.title = "Find Mike"
//        itemArray.append(newItem)
//
//        let newItem2 = Item()
//        newItem2.title = "Find Eggos"
//        itemArray.append(newItem2)
//
//        let newItem3 = Item()
//        newItem3.title = "Destory Demogorgon"
//        itemArray.append(newItem3)
        
        
        loadItems()
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
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

            let newItem = Item()
            newItem.title = textField.text!

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
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
            
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
      if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
          do {
          itemArray = try decoder.decode([Item].self, from: data)
          } catch {
              print("Error decoding item array, \(error)")
          }
            
        }
    }
}

