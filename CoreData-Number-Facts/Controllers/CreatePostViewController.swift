//
//  CreatePostViewController.swift
//  CoreData-Number-Facts
//
//  Created by Maitree Bain on 4/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

protocol CreatePostDelegate: AnyObject {
    func didCreatePost(_ createPostViewController: CreatePostViewController, post: Post)
}

class CreatePostViewController: UITableViewController {

    @IBOutlet weak var postTitleText: UITextField!
    @IBOutlet weak var numberFactsText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate: CreatePostDelegate?
    
    private var users = [User]()
    
    private var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePickerView()
        fetchUsers()
        selectedUser = users.first
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
        //validating data *checking to see its not empty or if data is valid(post title, number)
        //selected user
        
        guard let postTitle = postTitleText.text,
            !postTitle.isEmpty,
            let numberFactText = numberFactsText.text,
            !numberFactText.isEmpty,
            let numberFact = Double(numberFactText) else {
                print("missing fields")
                return
        }
    
        guard let user = selectedUser else { print("no user selected")
            return }
        
        //create post in core data
        let post = CoreDataManager.shared.createPost(for: user, numberFact: numberFact, title: postTitle)
        
        delegate?.didCreatePost(self, post: post)
        
        dismiss(animated: true)
    }
    
}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return users.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return users[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedUser = users[row]
        
        
    }
}
