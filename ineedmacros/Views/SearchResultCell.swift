//  Created by Kacper Jagiello on 19/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class SearchResultCell: UITableViewCell {

    let productName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let brandDetails: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    let productDetails: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        productDetails.addArrangedSubview(productName)
        productDetails.addArrangedSubview(brandDetails)
        addSubview(productDetails)
        
        productDetails.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 10, paddingLeft: 20, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
