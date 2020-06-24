//  Created by Kacper Jagiello on 16/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation

struct AdressBook {
    static private let authenticationToken = "2pe0zlHdThnwgTOpchbuYNLBbWyu8TCmDvDV8J0Y"
    static private var resourceAdress = "https://api.nal.usda.gov/fdc/v1/foods/search?api_key=\(authenticationToken)"
    
    static func createQuery(forKeyword keyword: String) -> String {
        return "\(resourceAdress)&query=\(keyword.replacingOccurrences(of: " ", with: ""))"
    }
}
