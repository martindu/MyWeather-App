//
//  ViewController.swift
//  MyWeather App
//
//  Created by Martin Dureja on 12/31/14.
//  Copyright (c) 2014 Martin Dureja. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    
    @IBOutlet var enteredCity: UITextField!
    
    @IBOutlet var weatherReport: UILabel!
    
    @IBAction func pressedButton(sender: AnyObject) {

    var finalReport = " "
        
        if(enteredCity.text != "" )
        {
            var urlString = "http://www.weather-forecast.com/locations/" + enteredCity.text.stringByReplacingOccurrencesOfString(" ", withString: "") + "/forecasts/latest"
        
            var url = NSURL(string: urlString)
        
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){ (data, response, error) in
                

            var urlContent = NSString (data: data, encoding: NSUTF8StringEncoding)!
        
            if urlContent.containsString("<span class=\"phrase\">"){
                
            
            var contentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
        
            var newContentArray = (contentArray[1] as NSString).componentsSeparatedByString("</span>")
            
        
        
            finalReport = (newContentArray[0] as String).stringByReplacingOccurrencesOfString("&deg;", withString: "º")
        }
        else{
                finalReport = "City Not Found!"
        }
            
        dispatch_async(dispatch_get_main_queue()){
            self.weatherReport.text = finalReport
                }
        }
        
        task.resume()
        
        }
        else{
        
            weatherReport.text = "Please enter a city!"
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

