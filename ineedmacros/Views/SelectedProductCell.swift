//  Created by Kacper Jagiello on 19/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class SelectedProductCell: UITableViewCell {

    private let productName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private let energyValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let productDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productDetails.addArrangedSubview(productName)
        productDetails.addArrangedSubview(energyValue)
        addSubview(productDetails)
    
        productDetails.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0, enableInsets: true)
    }
    
    func updateDetails(of product: Food) {
        productName.text = product.description
        energyValue.text = getEnergyValue(of: product)
    }
    
    private func getEnergyValue(of product: Food) -> String {
        var energyValue: String = ""
        guard let foodNutrients = product.foodNutrients else { return "NaN" }
        for nutrient in foodNutrients {
            if nutrient.nutrientId == 1062 {
                switch nutrient.unitName {
                case "kJ":
                    energyValue = "\(((nutrient.value ?? 0)/4.184).rounded()) kcal"
                default:
                    energyValue = "\(nutrient.value?.rounded() ?? 0) kcal"
                }
            }
        }
        return energyValue
    }
}
