//
//  CreateUserViewController.swift
//  CoreData-Number-Facts
//
//  Created by Maitree Bain on 4/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol CreateUserDelegate: AnyObject {
    func didCreateUser(_ viewcontroller: CreateUserViewController, user: User)
}

class CreateUserViewController: UITableViewController {
    
    @IBOutlet weak var userTextField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    weak var delegate: CreateUserDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.maximumDate = Date()
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        guard let userNameText = userTextField.text, !userNameText.isEmpty else { print("missing username")
            return
        }
        
        let date = datePicker.date
        
        //create a user
        let user = CoreDataManager.shared.createUser(name: userNameText, dob: date)
        
        delegate?.didCreateUser(self, user: user)
        
        dismiss(animated: true)
    }
    
}
