//  Created by Kacper Jagiello on 17/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import UIKit

class SearchForFoodTableViewController: UITableViewController {

    var addProductsDelegate: AddProductsDelegate?
    
    var selectedProducts = [Food]()
    
    var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.sizeToFit()
        return searchBar
    }()
    
    var searchResults = [Food]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.titleView = searchBar
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(handleDone))
        searchBar.delegate = self
        
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: "SearchResultCell")
    }
  
//MARK: Selectors
    @objc func handleDone() {
        addProductsDelegate?.add(products: selectedProducts)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Search Bar
extension SearchForFoodTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarQuery = searchBar.text else { return }
        
        let queryAdress = AdressBook.createQuery(forKeyword: searchBarQuery)
        let apiRequest = ApiRequest(fromAdress: queryAdress)
        
        apiRequest.getData { [weak self] (expectedData, error) in
            self?.searchResults = expectedData?.foods ?? []
        }
    }
}

//MARK: Table View Config
extension SearchForFoodTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let food = searchResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath) as! SearchResultCell
        cell.productName.text = food.description
        cell.brandDetails.text = food.brandOwner
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let queryResult = searchResults[indexPath.row]
        let foodDetails = FoodDetailsTableViewController()
        foodDetails.receivedProduct = queryResult
        foodDetails.receivedNutrients = queryResult.foodNutrients
        foodDetails.pickProductDelegate = self
        navigationController?.pushViewController(foodDetails, animated: true)
    }
}

extension SearchForFoodTableViewController: PickProductDelegate {
    func pick(product: Food) {
        selectedProducts.append(product)
    }
}
