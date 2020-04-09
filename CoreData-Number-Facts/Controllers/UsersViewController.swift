//
//  UsersViewController.swift
//  CoreData-Number-Facts
//
//  Created by Maitree Bain on 4/8/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var users = [User](){
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchUsers()
    }
    
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func fetchUsers() {
        users = CoreDataManager.shared.fetchUsers()
    }
    
    //get a ref to createUserVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createUserSegue" {
            guard let createUserVC = segue.destination as? CreateUserViewController else {
                fatalError("could not segue to createUserVC")
            }
            
            createUserVC.delegate = self
        }
    }
    
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension UsersViewController: CreateUserDelegate {
    func didCreateUser(_ viewcontroller: CreateUserViewController, user: User) {
        users.append(user) //will reload tv with new user
    }
    
    
}
