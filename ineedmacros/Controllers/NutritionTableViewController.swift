//  Created by Kacper Jagiello on 27/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class NutritionTableViewController: UITableViewController {
    
    var consumedProductsCombined = [Food]()
    var consumedNutrientsCombined = [Nutrient]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.title = "Nutrition"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(NutrientDetailsCell.self, forCellReuseIdentifier: "NutrientDetailsCell")
        
        combineConsumedProducts()
        combineConsumedNutrients()

        tableView.reloadData()
    }

    func combineConsumedProducts() {
        var mealsCombined = [Food]()
        for list in ConsumedProducts.shared.consumedSoFar {
            for product in list {
                mealsCombined.append(product)
            }
        }
        consumedProductsCombined = mealsCombined
    }
    
    func combineConsumedNutrients() {
        var nutrientsCombined = [Nutrient]()
        for product in consumedProductsCombined {
            guard let consumedNutrients = product.foodNutrients else { return }
            for nutrient in consumedNutrients {
                if nutrientsCombined.contains(where: { $0.nutrientId == nutrient.nutrientId }) {
                    if let indexOfAlreadyConsumedNutrient = nutrientsCombined.firstIndex(where: { $0.nutrientId == nutrient.nutrientId }) {
                        if nutrientsCombined[indexOfAlreadyConsumedNutrient].value != nil && nutrient.value != nil {
                            nutrientsCombined[indexOfAlreadyConsumedNutrient].value! += nutrient.value!
                            continue
                        }
                    }
                } else {
                    nutrientsCombined.append(nutrient)
                    continue
                }
            }
        }
        consumedNutrientsCombined = nutrientsCombined
    }
}

extension NutritionTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return consumedNutrientsCombined.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientDetailsCell", for: indexPath) as! NutrientDetailsCell
        let nutrientDescription = consumedNutrientsCombined[indexPath.row]
        cell.nutrientName.text = nutrientDescription.nutrientName
        cell.nutrientValue.text = "\(nutrientDescription.value ?? 0)"
        return cell
    }
}
