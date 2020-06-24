//  Created by Kacper Jagiello on 16/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation

struct Food: Decodable {
    let fdcId: Int?
    let description: String?
    let dataType: String?
    let brandOwner: String?
    let ingredients: String?
    var foodNutrients: [Nutrient]?
}

