//
//  ViewController.swift
//  API Calling
//
//  Created by Ella Wickstrom on 2/4/20.
//  Copyright © 2020 Ella Wickstrom. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    
    var marios = [[String : String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Different Marios"
        let query = "https://www.amiiboapi.com/api/amiibo/?character=mario"
        if let url = URL(string: query) {
            if let data = try? Data(contentsOf: url) {
                let json = try! JSON(data: data)
                parse(json: json)
                return
            }
        }
        loadError()
    }
    
    func parse(json: JSON) {
        for result in json["marios"].arrayValue {
            let name = result["name"].stringValue
            //let image = result["image"].stringValue
            let amiiboSeries = result["amiiboSeries"].stringValue
            let mario = ["name": name, "amiiboSeries": amiiboSeries]
            marios.append(mario)
        }
        tableView.reloadData()
    }
    
    func loadError () {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the marios.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

