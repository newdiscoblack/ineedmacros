//  Created by Kacper Jagiello on 16/04/2020.
//  Copyright © 2020 jagiello.com. All rights reserved.

import Foundation

class ApiRequest {
    
    private let dataAdress: URLRequest
    
    init(fromAdress adress: String) {
        let adressToUrl = URL(string: adress)
        var adressToUrlRequest = URLRequest(url: adressToUrl!)
        adressToUrlRequest.httpMethod = "GET"
        
        dataAdress = adressToUrlRequest
    }
    
    func getData(completionHandler: @escaping (SearchResults?, responseError?) -> Void) {
        let session = URLSession.shared.dataTask(with: dataAdress) { receivedData, _, _ in
            
            print(self.dataAdress)

            guard let jsonData = receivedData else {
                completionHandler(nil, .cannotReceiveData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(SearchResults.self, from: jsonData)
                let expectedData = decodedData

                completionHandler(expectedData, nil)
            } catch {
                completionHandler(nil, .errorAfterReceivingData)
            }
        }
        session.resume()
    }
}
