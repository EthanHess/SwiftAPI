//
//  NetworkController.swift
//  RepresentativeApp(Swift)
//
//  Created by Ethan Hess on 11/7/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

import UIKit

class NetworkController: NSObject {
    
    static let baseURLString = "http://whoismyrepresentative.com"
    
    static func searchURLbyState(state: String) -> NSURL {
        
        return NSURL(string: NetworkController.baseURLString + "/getall_reps_bystate.php?state=\(state)&output=json")!
    }
    
    static func dataAtURL(url: NSURL, completion:(resultData: NSData?) -> Void) {
        
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, response, error) -> Void in
            
            guard let data = data else {
                
                print(error?.localizedDescription)
                completion(resultData: nil)
                return
            }
            
            completion(resultData: data)
        }
        
        dataTask.resume()
        
    }

}
