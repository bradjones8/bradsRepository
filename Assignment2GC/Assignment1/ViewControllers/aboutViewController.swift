//
//  aboutViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class aboutViewController: UIViewController {
    
    @IBOutlet var tvPara : UITextView!
    @IBOutlet var navBar : UINavigationBar!


    override func viewDidLoad() {
        super.viewDidLoad()

        navBar!.setBackgroundImage(UIImage(), for: .default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
        navBar!.backgroundColor = .clear
        
       tvPara.backgroundColor = .clear
        
    }
    



}
