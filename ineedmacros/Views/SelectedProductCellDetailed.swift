//  Created by Kacper Jagiello on 19/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class SelectedProductCellDetailed: UITableViewCell {

    private let productName: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body).bold()
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
    
    private let nutrientsList: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        return stackView
    }()
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        productDetails.addArrangedSubview(productName)
        productDetails.addArrangedSubview(energyValue)
        addSubview(productDetails)
        addSubview(nutrientsList)

        productDetails.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 20, width: 0, height: 0, enableInsets: true)
        nutrientsList.anchor(top: productDetails.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 10, paddingRight: 20, width: 0, height: 0, enableInsets: true)
    }
    
    func updateDetails(of product: Food) {
        productName.text = product.description
        energyValue.text = getEnergyValue(of: product)
        
        for subview in nutrientsList.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        guard let foodNutrients = product.foodNutrients else { return }
        for nutrient in foodNutrients {
            let nutrientLabel: UILabel = {
                let label = UILabel()
                label.textColor = .darkGray
                return label
            }()
            
            let nutrientValue: UILabel = {
                let label = UILabel()
                label.textColor = .lightGray
                return label
            }()
            
            let nutrientInfo: UIStackView = {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.distribution = .equalSpacing
                stackView.spacing = 10
                return stackView
            }()
            
            nutrientLabel.text = "\(nutrient.nutrientName ?? "NaN")"
            nutrientValue.text = "\(nutrient.value ?? 0)\(nutrient.unitName ?? "")"
            
            nutrientInfo.addArrangedSubview(nutrientLabel)
            nutrientInfo.addArrangedSubview(nutrientValue)
            nutrientsList.addArrangedSubview(nutrientInfo)
        }
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
