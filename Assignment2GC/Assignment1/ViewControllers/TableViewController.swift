//
//  TableViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-10-13.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
     @IBOutlet var navBar : UINavigationBar!

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return mainDelegate.users.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell  = tableView.dequeueReusableCell(withIdentifier: "cell") as? SiteCell ?? SiteCell(style: .default, reuseIdentifier: "cell")
        
        let rowNum = indexPath.row
        tableCell.primaryLabel.text = mainDelegate.users[rowNum].savedName
        tableCell.secondaryLabel.text = mainDelegate.users[rowNum].savedEmail
        if mainDelegate.users[rowNum].savedAvatar == 1 {
            tableCell.myImageView.image = UIImage(named: "maleAvatar.jpg")
        }
        if mainDelegate.users[rowNum].savedAvatar == 2 {
            tableCell.myImageView.image = UIImage(named: "femaleAvatar.jpg")
        }
        if mainDelegate.users[rowNum].savedAvatar == 3 {
            tableCell.myImageView.image = UIImage(named: "beanAvatar.jpg")
        }
        
        if mainDelegate.users[rowNum].savedAvatar == 0 {
                   tableCell.myImageView.image = UIImage(named: "assImageSign.jpg")
               }
        
        tableCell.accessoryType = .disclosureIndicator
        return tableCell
    }
    
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
    */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navBar!.setBackgroundImage(UIImage(), for: .default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
        navBar!.backgroundColor = .clear
               
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
