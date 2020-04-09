//
//  CoreDataManager.swift
//  CoreData-Number-Facts
//
//  Created by Maitree Bain on 4/9/20.
//  Copyright © 2020 Maitree Bain. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    private init() { }
    
    private var users = [User]() // User is a NSManagedObject
           
    private var posts = [Post]()
    
    //we need to access the persistence container in the app delegate
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //viewContext is of type NSManagedObjectContext
    
    //CRUD - Create, Read, Update, Delete
    
    public func createUser(name: String, dob: Date) -> User {
        let user = User(entity: User.entity(), insertInto: context)
        user.name = name
        user.dob = dob
        
        //Save to NSManagedContext
        //similar to saving to fileManager
        
        do{
            try context.save()
        } catch {
            print("error saving user: \(error)") //NSManagedObject
        }
        return user
//        let post = Post(entity: Post.entity(), insertInto: context)
    }
    
    public func fetchUsers() -> [User] {
        do {
            users = try context.fetch(User.fetchRequest())
        } catch {
            print("error fetching users: \(error)")
        }
        
        return users
    }
    
    
    public func createPost(for user: User, numberFact: Double, title: String) -> Post {
        let post = Post(entity: Post.entity(), insertInto: context)
        post.user = user
        post.number = numberFact
        post.title = title
        
        do {
            try context.save()
        } catch {
            print("error saving post: \(error)")
        }
        
        return post
    }
    
    public func fetchPost() -> [Post]{
        
        do {
            posts = try context.fetch(Post.fetchRequest())
        } catch {
            print("error fetching posts: \(error)")
        }
        
        return posts
    }
    
    @discardableResult
    private func deletePost(_ post: Post) -> Bool{
        var wasDeleted = false
        context.delete(post)
        
        do{
            try context.save()
            wasDeleted = true
        } catch {
            print("could not delete post: \(error)")
        }
        
        return wasDeleted
    }
    
}
