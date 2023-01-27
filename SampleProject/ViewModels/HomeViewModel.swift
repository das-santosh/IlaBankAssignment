//
//  HomeViewModel.swift
//  SampleProject
//
//  Created by neosoft on 27/01/23.
//

import UIKit

class HomeViewModel {
    //MARK:  declare variable to store data
    var carousalData: [CarouselList]?
    var details: [Detail]?
    var filterData: [Detail]?
    
    func loadData(_ completion: @escaping(()-> Void)) {
        do {
            if let bundlePath = Bundle.main.path(forResource: "CarouselData", ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                self.parse(jsonData: jsonData)
            }
        } catch {
            print(error)
        }
        completion()
    }
    
    //MARK: This method is used to Map data to Model object
    private func parse(jsonData: Data) {
        do {
            let decodedData = try JSONDecoder().decode(CarouselData.self, from: jsonData)
            carousalData = decodedData
            if let detail = decodedData.first?.details {
                self.filterData = detail
                self.details = detail
            }
        } catch {
            print("decode error")
        }
    }
    
    //Filter data according to search text entry
    func filterProduct(text: String) {
        details = text.isEmpty ? filterData : filterData?.filter { $0.text!.contains(text) }
    }
    
}

