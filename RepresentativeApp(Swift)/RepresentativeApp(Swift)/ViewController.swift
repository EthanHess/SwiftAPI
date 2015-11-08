//
//  ViewController.swift
//  RepresentativeApp(Swift)
//
//  Created by Ethan Hess on 11/7/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let states = ["AK", "AL", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"]
    var resultsReps: [Representative] = []
    var pickerView : UIPickerView!
    var searchButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        pickerView = UIPickerView(frame: CGRectMake(0, 200, self.view.frame.size.width, 200))
        pickerView.delegate = self
        pickerView.dataSource = self
        self.view.addSubview(pickerView)
        
        searchButton = UIButton(frame: CGRectMake(50, 100, self.view.frame.size.width - 100, 50))
        searchButton.layer.cornerRadius = 10
        searchButton.layer.borderColor = UIColor.blackColor().CGColor
        searchButton.layer.borderWidth = 1
        searchButton.setTitle("Search", forState: UIControlState.Normal)
        searchButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        searchButton.titleLabel?.font = UIFont(name: "Chalkduster", size: 16)
        searchButton.addTarget(self, action: "searchPressed", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(searchButton)
        
    }
    
    //search method
    
    func searchPressed() {
        
        let index = pickerView.selectedRowInComponent(0)
        
        let stateString = states[index]
        
        RepresentativeController.searchRepsByState(stateString) { (representatives) -> Void in
            
            if representatives.count > 0 {
                
                self.resultsReps = representatives
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    let resultsTableVC = ResultsTableViewController()
                    
                    resultsTableVC.repsArray = self.resultsReps
                    
                    self.navigationController?.pushViewController(resultsTableVC, animated: true)
                })
                
            }
        }
        
    }
    
    //UIPickerView methods
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return states.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.states[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //TODO: add results controller and detail VC's
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

