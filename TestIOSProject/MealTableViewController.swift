//
//  MealTableViewController.swift
//  TestIOSProject
//
//  Created by User on 21.04.2020.
//  Copyright © 2020 User. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    // var -> variable; array mutable
    var meals = [Meal]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Load the sample data
        loadSampleMeals()
    }

    // MARK: - Table view data source
// tells the table view how many sections to display. Sections are the visual grouping of cell within table views, which is esprcially in table views with alot of data
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    // tells the table view how many rows to display in given section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return meals.count
    }

    // configures and provides a cell to display for a given row. Each row in table view has one cell, and that cell determinates the content that appeares in that raw
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // dequeueReusableCell tell which type of cell it should crete or reuse
        // Table view cells a reused and should be dequeued using a cell identifier
        let cellIdentifier = "MealTableViewCell"
        //Because created a custom cell class? downcast the type of the cell to your custom cell subclass? MealTableViewCell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)  as? MealTableViewCell else {
            
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout
        let meal = meals[indexPath.row]
        cell.nameLabl.text = meal.name
        cell.photoimageView.image = meal.photo
        cell.ratingControl.rating = meal.rating
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue){
        
        if let sourceViewController = sender.source as? MealViewController, let meal = sourceViewController.meal{
            // Add a new meal; computes the location where new item will be inserted and stored it in a local constant called newIndexPath
            let newIndexPath = IndexPath(row: meals.count, section: 0)
            meals.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }
    
    // MARK: Private Methods
    private func loadSampleMeals(){
      let photo1 = UIImage(named: "meal1")
      let photo2 = UIImage(named: "meal2")
      let photo3 = UIImage(named: "meal3")
        
        guard let meal1 = Meal(name: "Salad", photo: photo1 , rating: 4) else {
            fatalError("Unable to instantiate meal1")
        }
        guard let meal2 = Meal(name: "Salad", photo: photo2, rating: 3) else {
            fatalError("Unable to instantiate meal2")
        }
        guard let meal3 = Meal(name: "Potatos", photo: photo3, rating: 2) else{
            fatalError("Unable to instantiate meal3")
        }
        meals += [meal1, meal2, meal3]
    }
    
}
