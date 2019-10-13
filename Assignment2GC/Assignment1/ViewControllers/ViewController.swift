//
//  ViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    //Unwind function
    @IBAction func unwindToHomeVC(sender : UIStoryboardSegue)
    {
        mainDelegate.avatar = 0
    }
    

}

