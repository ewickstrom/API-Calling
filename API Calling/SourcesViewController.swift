//
//  ViewController.swift
//  API Calling
//
//  Created by Ella Wickstrom on 2/4/20.
//  Copyright © 2020 Ella Wickstrom. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {

    var sources = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Important Hogwarts Students"
        let query = "http://hp-api.herokuapp.com/api/characters/students"
    }


}

