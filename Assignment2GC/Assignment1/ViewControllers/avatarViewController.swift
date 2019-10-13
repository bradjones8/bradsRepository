//
//  avatarViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-10-12.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class avatarViewController: UIViewController {
    @IBOutlet var imageView1 : UIImageView!
    @IBOutlet var imageView2 : UIImageView!
    @IBOutlet var imageView3 : UIImageView!
    @IBOutlet var navBar : UINavigationBar!
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate


    let imageArray:[String] = ["maleAvatar.jpg", "femaleAvatar.jpg", "beanAvatar.jpg"]

    override func viewDidLoad() {
        super.viewDidLoad()
        navBar!.setBackgroundImage(UIImage(), for: .default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
        navBar!.backgroundColor = .clear
        

    }
    
    @IBAction func imagebtn1(sender: UIButton)
    {
        mainDelegate.avatar = 1
    }
    
    @IBAction func imagebtn2(sender: UIButton)
       {
           mainDelegate.avatar = 2
       }
    

    @IBAction func imagebtn3(sender: UIButton)
       {
           mainDelegate.avatar = 3
       }
    
}
