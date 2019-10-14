//
//  registrationViewController.swift
//  Assignment1
//
//  Created by Bradley Jones on 2019-09-21.
//  Copyright © 2019 Bradley Jones. All rights reserved.
//

import UIKit

class registrationViewController: UIViewController {
    
    @IBOutlet var tfName : UITextField!
    @IBOutlet var tfAddress : UITextField!
    @IBOutlet var tfPhone : UITextField!
    @IBOutlet var tfEmail : UITextField!
    @IBOutlet var tfDOB : UITextField!
    @IBOutlet var slAge : UISlider!
    @IBOutlet var swGender : UISwitch!
    @IBOutlet var lbAge : UILabel!
    @IBOutlet var lbMale : UILabel!
    @IBOutlet var lbFemale : UILabel!
    @IBOutlet var navBar : UINavigationBar!
    @IBOutlet var avatarImageView : UIImageView!
    var gender : String = "Male"
    let date = Date()
    private var datePicker: UIDatePicker!
    var image : UIImage?
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate



    override func viewDidLoad() {
        super.viewDidLoad()
        lbFemale.isHidden = true
        navBar!.setBackgroundImage(UIImage(), for: .default)
        navBar!.shadowImage = UIImage()
        navBar!.isTranslucent = true
        navBar!.backgroundColor = .clear
        datePicker = UIDatePicker()
        datePicker.maximumDate = date
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        
        tfDOB.inputView = datePicker
        
        if(mainDelegate.avatar == 0)
        {
            avatarImageView.image = UIImage(named: "assImageSign.jpg")
        }
        if(mainDelegate.avatar == 1)
        {
            avatarImageView.image = UIImage(named: "maleAvatar.jpg")
        }
        if(mainDelegate.avatar == 2)
        {
            avatarImageView.image = UIImage(named: "femaleAvatar.jpg")
        }
        if(mainDelegate.avatar == 3)
        {
            avatarImageView.image = UIImage(named: "beanAvatar.jpg")
        }

    let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
      
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        tfDOB.inputAccessoryView = toolBar
        
        
    }
    

    @IBAction func submit(sender : UIButton)
    {
        
       
        let user : UserClass = .init()
        user.createUser(theID: (mainDelegate.users.count + 1), theName: tfName.text!, theAddress: tfAddress.text!, thePhone: tfPhone.text!, theEmail: tfEmail.text!, theAge: Int(lbAge.text!)!, theGender: gender, theDOB: tfDOB.text!, theAvatar: mainDelegate.avatar)
        
        mainDelegate.users.append(user)
        mainDelegate.insertToDatabase(user: user)
         mainDelegate.avatar = 0
        let alert = UIAlertController(title: "Thank You", message: "Thanks " + (tfName.text!) + ", of " + (tfEmail.text!) + " for registering with us.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: {(alert : UIAlertAction!) in
            
            self.dismiss(animated: true, completion:
                nil)
            
            
            
        })
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
        
    
    func updateLabel()
    {
        let age = slAge.value
        let strAge = String(format: "%.0f", age)
        lbAge.text = strAge
    }
    
    
    @IBAction func sliderValueChanged(sender : UISlider)
    {
        updateLabel()
    }
    
    
    @IBAction func switchValueChanged (sender : UISwitch)
    {
        
        updateGender()
    }
    
    func updateGender()
    {
        if swGender.isOn == true
        {
            lbMale.isHidden = true
            lbFemale.isHidden = false
            gender = "Female"
        }
        else
        {
            lbFemale.isHidden=true
            lbMale.isHidden = false
            gender = "Male"
        }
        
    }
    
 
    @IBAction func dateChanged(sender : UIDatePicker)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        tfDOB.text = dateFormatter.string(from: datePicker.date)
    }
    
 
    @objc func doneClick()
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        tfDOB.text = dateFormatter.string(from: datePicker.date)
        tfDOB.resignFirstResponder()
        
    }
    
    @objc func cancelClick()
    {
        tfDOB.text = ""
        tfDOB.resignFirstResponder()
    }
    
    
    @IBAction func unwindToRegVC(sender : UIStoryboardSegue)
       {
           if(mainDelegate.avatar == 0)
           {
               avatarImageView.image = UIImage(named: "assImageSign.jpg")
           }
           if(mainDelegate.avatar == 1)
           {
               avatarImageView.image = UIImage(named: "maleAvatar.jpg")
           }
           if(mainDelegate.avatar == 2)
           {
               avatarImageView.image = UIImage(named: "femaleAvatar.jpg")
           }
           if(mainDelegate.avatar == 3)
           {
               avatarImageView.image = UIImage(named: "beanAvatar.jpg")
           }
       }
   
    func textFieldShouldReturn(_  textField : UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    
}
