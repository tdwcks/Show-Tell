//
//  NavigationController.swift
//  Show & Tell
//
//  Created by Tom Wicks on 06/04/2016.
//  Copyright © 2016 Miln. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define Navigation Styles
        
        let navigationStyle = [
            NSForegroundColorAttributeName: UIColor.darkGrayColor(),
            NSFontAttributeName: UIFont(name: "GT Walsheim", size: 16)!
        ]
        
        // Initialise Navigation Styles
        
        self.navigationController?.navigationBar.titleTextAttributes = navigationStyle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
