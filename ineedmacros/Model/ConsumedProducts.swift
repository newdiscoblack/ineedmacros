//  Created by Kacper Jagiello on 27/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation
import UIKit

enum ProductList {
    case breakfast
    case dinner
    case supper
}

class ConsumedProducts {
    static let shared = ConsumedProducts()
    let totalNutrients = NutritionTableViewController()
    
    var consumedSoFar = [[Food](), [Food](), [Food]()]
    
    func update(list: ProductList, with products: [Food]) {
        switch list {
        case .breakfast:
            consumedSoFar[0] = products
        case .dinner:
            consumedSoFar[1] = products
        case .supper:
            consumedSoFar[2] = products
        }
    }
}
