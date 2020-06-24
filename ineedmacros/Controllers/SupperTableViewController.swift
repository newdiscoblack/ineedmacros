//  Created by Kacper Jagiello on 17/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation
import UIKit

class SupperTableViewController: UITableViewController {
    
    private var nutrientsAreDisplayed = false
    private var nutritionSummaryButton = UIBarButtonItem()
    
    var supper = [Food]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
                ConsumedProducts.shared.update(list: .supper, with: self?.supper ?? [])
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        
        tableView.register(SelectedProductCell.self, forCellReuseIdentifier: "SelectedProductCell")
        tableView.register(SelectedProductCellDetailed.self, forCellReuseIdentifier: "SelectedProductCellDetailed")
       }
    
    private func setupNavigationBar() {
        nutritionSummaryButton = UIBarButtonItem(title: "Show Nutrients", style: .plain, target: self, action: #selector(showNutrients))
        let addProductButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddFood))
        navigationItem.rightBarButtonItems = [addProductButton, nutritionSummaryButton]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Supper"
    }
    
    @objc func showNutrients() {
           if !nutrientsAreDisplayed {
               nutrientsAreDisplayed = true
               nutritionSummaryButton.title = "Hide Nutrients"
           } else if nutrientsAreDisplayed {
               nutrientsAreDisplayed = false
               nutritionSummaryButton.title = "Show Nutrients"
           }
           tableView.reloadData()
    }
    
    @objc func handleAddFood() {
        let searchFoodController = SearchForFoodTableViewController()
        searchFoodController.addProductsDelegate = self
        
        present(UINavigationController(rootViewController: searchFoodController), animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return supper.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let defaultTableViewCellHeight = CGFloat(44)
        let numberOfNutrientsPerProduct = CGFloat(supper[indexPath.row].foodNutrients?.count ?? 1)
        let approximateRowHeight = numberOfNutrientsPerProduct * defaultTableViewCellHeight
        
        switch nutrientsAreDisplayed {
        case false:
            return defaultTableViewCellHeight
        case true:
            return approximateRowHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = supper[indexPath.row]
        
        switch nutrientsAreDisplayed {
        case false:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedProductCell") as! SelectedProductCell
            cell.updateDetails(of: food)
            return cell
        case true:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedProductCellDetailed") as! SelectedProductCellDetailed
            cell.updateDetails(of: food)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            supper.remove(at: indexPath.row)
        }
    }
}

extension SupperTableViewController: AddProductsDelegate {
    func add(products: [Food]) {
        for product in products {
            supper.append(product)
        }
    }
}
