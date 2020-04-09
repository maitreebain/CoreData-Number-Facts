//
//  CreatePostViewController.swift
//  CoreData-Number-Facts
//
//  Created by Maitree Bain on 4/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class CreatePostViewController: UITableViewController {

    @IBOutlet weak var postTitleText: UITextField!
    @IBOutlet weak var numberFactsText: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configurePickerView()
    }
    
    private func configurePickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }

    @IBAction func submitButtonPressed(_ sender: UIButton) {
        
    }
    
}

extension CreatePostViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "Title"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}
