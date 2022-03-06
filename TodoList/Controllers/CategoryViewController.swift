//
//  CategoryViewController.swift
//  TodoList
//
//  Created by Yashom on 06/03/22.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    var categories = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - TableView Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        //cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //Mark: - Data Manipulation Methods
    
    //Mark - Add New Categories
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
 
    
    //Mark: - TableView Delegate Methods
    
 
}
