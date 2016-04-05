//
//  ViewController.swift
//  Show & Tell
//
//  Created by Tom Wicks on 05/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define Navigation Styles
        
        let navigationStyle = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont(name: "GT Walsheim", size: 16)!
        ]
        
        // Initialise Navigation Styles
        
        self.navigationController?.navigationBar.titleTextAttributes = navigationStyle
        
        for parent in self.navigationController!.navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

