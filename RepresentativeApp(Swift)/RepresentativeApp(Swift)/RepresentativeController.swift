//
//  RepresentativeController.swift
//  RepresentativeApp(Swift)
//
//  Created by Ethan Hess on 11/7/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

import Foundation

class RepresentativeController {
    
    static func searchRepsByState(state: String, completion: (representatives: [Representative]) -> Void) {
        
        let url = NetworkController.searchURLbyState(state)
        
        NetworkController.dataAtURL(url) { (resultData) -> Void in
            guard let representativeData = resultData  else {
                print("NO DATA RETURNED")
                completion(representatives: [])
                return
            }
            
            do {
                let resultsDictionary = try NSJSONSerialization.JSONObjectWithData(representativeData, options: NSJSONReadingOptions.AllowFragments) as! [String : AnyObject]
                
                let representativeDictionaries = resultsDictionary[Representative.kResultsKey] as! [[String : String]]
                
                var arrayOfRepresentativeModelObjects: [Representative] = []
                
                for dictionary in representativeDictionaries {
                    let rep = Representative(jsonDictionary: dictionary)
                    arrayOfRepresentativeModelObjects.append(rep)
                }
                
                completion(representatives: arrayOfRepresentativeModelObjects)
                
            } catch {
                print("Error serializing JSON")
                completion(representatives: [])
                return
            }
        }
    }
}