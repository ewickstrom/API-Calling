//
//  ViewController.swift
//  API Calling
//
//  Created by Ella Wickstrom on 2/4/20.
//  Copyright © 2020 Ella Wickstrom. All rights reserved.
//

import UIKit

class SourcesViewController: UITableViewController {
    
    var amiibo = [[String : String]]()
    
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
        for result in json["amiibo"].arrayValue {
            let name = result["name"].stringValue
            //let image = result["image"].stringValue
            let amiiboSeries = result["amiiboSeries"].stringValue
            let mario = ["name": name, "amiiboSeries": amiiboSeries]
            amiibo.append(mario)
        }
        tableView.reloadData()
    }
    
    func loadError () {
        let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the marios.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return amiibo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let mario = amiibo[indexPath.row]
        cell.textLabel?.text = mario["name"]
        cell.detailTextLabel?.text =  mario["amiiboSeries"]
        return cell
    }
    
}

