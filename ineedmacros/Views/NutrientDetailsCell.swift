//  Created by Kacper Jagiello on 19/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class NutrientDetailsCell: UITableViewCell {

    let nutrientName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        return label
    }()
    
    let nutrientValue: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        detailsStackView.addArrangedSubview(nutrientName)
        detailsStackView.addArrangedSubview(nutrientValue)
        
        addSubview(detailsStackView)

        detailsStackView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 20, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
