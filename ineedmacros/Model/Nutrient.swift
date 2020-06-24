//  Created by Kacper Jagiello on 16/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation

struct Nutrient: Decodable {
    let nutrientId: Int?
    let nutrientName: String?
    let nutrientNumber: String?
    let unitName: String?
    var value: Float?
}
