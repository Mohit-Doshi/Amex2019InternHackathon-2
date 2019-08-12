//
//  CarpoolsViewController.swift
//  FindAPool
//
//  Created by Mohit on 08/08/19.
//  Copyright © 2019 forty-two. All rights reserved.
//

import UIKit

class CarpoolsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sentClass:[CurrentRoutes]?
    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sentClass?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CarPoolTableViewCell
        cell.layer.borderWidth = 1.0
        cell.NameLabel.text = sentClass![indexPath.row].name
        cell.DistanceLabel.text = cell.DistanceLabel.text! + " " + sentClass![indexPath.row].distanceofcarpool! + " miles"
        cell.DurationLabel.text = cell.DurationLabel.text! + " " + sentClass![indexPath.row].durationofcarpool!
        //cell.TimeLabel.text = cell.TimeLabel.text! + " " + "\(sentClass![indexPath.row].reachingtime - Float(sentClass![indexPath.row].durationofcarpool!)!)"
        
        print(cell.NameLabel.text)
        print(cell.DistanceLabel.text)
        print(cell.DurationLabel.text)
        
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        let selectedIndex: IndexPath = self.tableView.indexPath(for: sender as! UITableViewCell)!
        let des = segue.destination as! RouteViewController
        // Pass the selected object to the new view controller.
        des.mainobj = (sentClass![selectedIndex.row])
    }
 

}
