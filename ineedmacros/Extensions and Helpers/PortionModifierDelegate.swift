//  Created by Kacper Jagiello on 29/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation

protocol PortionModifierDelegate {
    func collect(value: Float)
    func modifyPortion()
}
