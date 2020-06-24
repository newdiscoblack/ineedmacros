//  Created by Kacper Jagiello on 19/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class FoodDetailsTableViewController: UITableViewController {
    
    var pickProductDelegate: PickProductDelegate?
    var pickedCounter: Int = 0
    
    var receivedProduct: Food?
    var receivedNutrients: [Nutrient]?
    
    var hasProductBeenModified = false
    var portionModifier: Float = 1
    var modifiedProduct: Food?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let addProductBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddFood))
        let editProductBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(changePortion))
        let rightBarButtonItems = [addProductBarButton, editProductBarButton]
        
        navigationItem.rightBarButtonItems = rightBarButtonItems
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = receivedProduct?.description
        
        tableView.register(NutrientDetailsCell.self, forCellReuseIdentifier: "NutrientDetailsCell")
    }

    //MARK: Selectors
    @objc func handleAddFood() {
        let pickedProduct = hasProductBeenModified ? modifiedProduct : receivedProduct
        pickProductDelegate?.pick(product: pickedProduct!)
        pickedCounter += 1

        if pickedCounter <= 1 {
            navigationItem.title = "Product added."
        } else {
            navigationItem.title = "Added \(pickedCounter) times"
        }
    }
    
    @objc func changePortion() {
        let target = PortionPickerViewController()
        target.valueReceiver = self
        present(UINavigationController(rootViewController: target), animated: true, completion: nil)
    }
}

//MARK: Table View Config
extension FoodDetailsTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return receivedNutrients?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayedNutrient = hasProductBeenModified ? modifiedProduct?.foodNutrients?[indexPath.row] : receivedProduct?.foodNutrients?[indexPath.row]
        
        let nutrientName = displayedNutrient?.nutrientName ?? "No name found"
        let nutrientValue = displayedNutrient?.value ?? 0
        let nutrientValueUnit = displayedNutrient?.unitName ?? "?"

        let cell = tableView.dequeueReusableCell(withIdentifier: "NutrientDetailsCell", for: indexPath) as! NutrientDetailsCell
        cell.nutrientName.text = nutrientName
        cell.nutrientValue.text = "\(nutrientValue) \(nutrientValueUnit)"
        return cell
    }
}

//MARK: Value Receiver
extension FoodDetailsTableViewController: PortionModifierDelegate {
    func collect(value: Float) {
        portionModifier = value
        print("Portion modifier: \(portionModifier)")
    }
    
    func modifyPortion() {
        var modifiedNutrients = [Nutrient]()
        hasProductBeenModified = true
        guard let selectedProduct = receivedProduct else { return }
        guard let productNutrients = selectedProduct.foodNutrients else { return }
        for var receivedNutrient in productNutrients {
            receivedNutrient.value? *= portionModifier
            modifiedNutrients.append(receivedNutrient)
        }
        modifiedProduct = selectedProduct
        modifiedProduct?.foodNutrients = modifiedNutrients
        tableView.reloadData()
    }
}

