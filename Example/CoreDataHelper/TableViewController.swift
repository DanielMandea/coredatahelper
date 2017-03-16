//
//  ViewController.swift
//  CoreDataHelper
//
//  Created by DanielMandea on 03/14/2017.
//  Copyright (c) 2017 DanielMandea. All rights reserved.
//

import UIKit
import CoreData
import CoreDataHelper

class TableViewController: UITableViewController {
    
    // MARK: - Internal Values 
    
    var dataManager: DataManager!
    
    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        dataManager = DataManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource 
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.allUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell {
            dataManager.configureCell(cell: cell, for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK: - IBActions 
    
    @IBAction func loadData(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        dataManager.fetch { (success, error) in
            sender.endRefreshing()
            self.tableView.reloadData()
        }
    }
    

}


