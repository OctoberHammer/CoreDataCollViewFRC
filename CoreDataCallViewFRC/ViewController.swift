//
//  ViewController.swift
//  CoreDataCallViewFRC
//
//  Created by October Hammer on 10/19/17.
//  Copyright © 2017 Ocotober Hammer. All rights reserved.
//

import UIKit
import Crashlytics

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func crashTest(_ sender: UIButton) {
            Crashlytics.sharedInstance().crash()
    }
    
}

