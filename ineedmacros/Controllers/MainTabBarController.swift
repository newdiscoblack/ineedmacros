//  Created by Kacper Jagiello on 13/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var breakfastTab = tabBar.items?[0]
    private lazy var dinnerTab = tabBar.items?[1]
    private lazy var supperTab = tabBar.items?[2]
    private lazy var nutritionTab = tabBar.items?[3]
    
    override func viewWillAppear(_ animated: Bool) {
        setupTabbarTitles()
        setupTabbarImages()
    }
    
    private func setupTabbarTitles() {
        breakfastTab?.title = "Breakfast"
        dinnerTab?.title = "Dinner"
        supperTab?.title = "Supper"
        nutritionTab?.title = "Nutrition"
    }
    
    private func setupTabbarImages() {
        breakfastTab?.image = UIImage(named: "breakfastTabbarIcon")
        dinnerTab?.image = UIImage(named: "dinnerTabbarIcon")
        supperTab?.image = UIImage(named: "supperTabbarIcon")
        nutritionTab?.image = UIImage(named: "nutritionTabbarIcon")
    }
}
