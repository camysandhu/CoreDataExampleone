//
//  ViewController.swift
//  CoreDataExample
//
//  Created by MacStudent on 2020-01-15.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var score = Int()
    @IBOutlet weak var lblSpeed: UILabel!
    override func viewDidLoad() {
        getData()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblSpeed.text = "\(score)"
    }

    @IBAction func btnIncrease(_ sender: Any) {
        score += 1
        lblSpeed.text = "\(score)"
    }
    
    @IBAction func btnSave(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context)
        let newEntity = NSManagedObject(entity: entity!, insertInto: context)
        newEntity.setValue(score, forKey: "number")
        do {
            try context.save()
            print("saved")
        } catch  {
    print("Failed")
        }
    }
    func getData()
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject]
            {
                score = data.value(forKey: "number") as! Int
            }
        } catch  {
            print("Failed")
        }
    }
}

