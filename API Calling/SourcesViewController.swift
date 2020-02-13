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
        DispatchQueue.global(qos: .userInitiated).async {
            [unowned self] in
            if let url = URL(string: query) {
                if let data = try? Data(contentsOf: url) {
                    let json = try! JSON(data: data)
                    self.parse(json: json)
                    return
                }
            }
            self.loadError()
        }
    }
    
    func parse(json: JSON) {
        for result in json["amiibo"].arrayValue {
            let name = result["name"].stringValue
            let url = result["image"].stringValue
            let amiiboSeries = result["amiiboSeries"].stringValue
            let mario = ["name": name, "amiiboSeries": amiiboSeries, "url": url]
            amiibo.append(mario)
        }
        DispatchQueue.main.async {
            [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    func loadError () {
        DispatchQueue.main.async {
            [unowned self] in
            let alert = UIAlertController(title: "Loading Error", message: "There was a problem loading the marios.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: amiibo[indexPath.row]["url"]!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func onTappedDoneButton(_ sender: Any) {
        exit(0)
    }
    
    
    
}

