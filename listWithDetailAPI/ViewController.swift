//
//  ViewController.swift
//  listWithDetailAPI
//
//  Created by Jeremy Gerald Prawira on 06/08/22.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let tableView = UITableView()
    var mealList = [Meal]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let anonymousFunction = { (fetchedMealList: [Meal]) in
            DispatchQueue.main.async {
                self.mealList = fetchedMealList
                self.tableView.reloadData()
            }
        }
        
        MealAPI.shared.fetchListMeal(onCompletion: anonymousFunction)
        
        
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let meal = mealList[indexPath.row]
        cell.textLabel?.text = meal.strMeal
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Cell Tapped")
    }
}

