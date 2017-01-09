//
//  ViewController.swift
//  CoreDataTestProject
//
//  Created by sazzad on 1/9/17.
//  Copyright © 2017 Dynamic Solution Innovators. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var arrayOfUsers = [Users]()
    var context: NSManagedObjectContext!
    @IBOutlet weak var id: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    @IBAction func deleteAction(_ sender: UIButton) {
        let userRequest : NSFetchRequest<Users> = Users.fetchRequest()
        
        let listUsers = try! context.fetch(userRequest)
        print(listUsers.count)
        context.delete(listUsers.first!)
    }
    
    
    @IBAction func update(_ sender: UIButton) {
        let userRequest : NSFetchRequest<Users> = Users.fetchRequest()
        let filter = 4
        let myPredicate = NSPredicate(format: "id == 22")
        let listUsers = try! context.fetch(userRequest).filter {myPredicate.evaluate(with: ($0))}
        if listUsers.count > 0 {
            let theUser = listUsers.first!
            theUser.id = Int64(id.text!)! * 5
            //try? context.save()
        }
        
    }
    
    
    @IBAction func show(_ sender: Any) {
        let userRequest : NSFetchRequest<Users> = Users.fetchRequest()
        arrayOfUsers = try! context.fetch(userRequest)
        print(arrayOfUsers.count)
        for user in arrayOfUsers {
            print(user.id)
        }
    }

    @IBAction func save(_ sender: UIButton) {
        let users = Users(context: context)
        users.id = Int64(id.text!)!
        users.name = "name\(name.text)"
        users.address = "address\(id.text)"
        try? context.save()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
    }


}

func getCurrentMillis() -> Int64 {
    return Int64(Date().timeIntervalSince1970 * 1000)
}
