//
//  Predators.swift
//  JPApexPredators
//
//  Created by Collin Schmitt on 10/12/24.
//

//foundation is a framework that gives us access to some decoding stuff we will be using
import Foundation


class Predators{
    var allApexPredators: [ApexPredator] = []
    var apexPredators: [ApexPredator] = []
    
    
    init(){
        decodeApexPredatorData()
    }
    //decode function
    func decodeApexPredatorData(){
        //if let protects the app from crashing if something goes wrong
        if let url = Bundle.main.url(forResource: "jpapexpredators", withExtension: "json"){
            do{
                //try to get the data from the json file and store in the data property so we can decode it
                let data = try Data(contentsOf: url)
                
                //need a decoder that works with the data we are decoding
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase //have snake case in the json data, need to convert to camelcase for model
                allApexPredators = try decoder.decode([ApexPredator].self, from: data)
                apexPredators = allApexPredators
            } catch{
                print("Error decoding JSON data: \(error)")
            }
        }
    }
    
    func search(for searchTerm: String) -> [ApexPredator]{
        //if no search, give us all the dinosaurs, otherwise give us whatever the user types in search
        if searchTerm.isEmpty{
            return apexPredators
        }
        else{
            return apexPredators.filter{
                predator in predator.name.localizedCaseInsensitiveContains(searchTerm)
            }
        }
    }
    
    func sort(by alphabetical: Bool){
        apexPredators.sort { predator1, predator2 in
            if alphabetical{
                predator1.name < predator2.name
            } else{
                predator1.id < predator2.id
            }
        }
    }
    
    //filter by type
    func filter(by type: APType){
        if type == .all{
            apexPredators = allApexPredators
        }else{
            apexPredators = allApexPredators.filter{ predator in
                predator.type == type
            }
        }
    }
}
