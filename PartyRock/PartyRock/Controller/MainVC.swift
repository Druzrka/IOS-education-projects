//
//  ViewController.swift
//  PartyRock
//
//  Created by Захар on 23.09.17.
//  Copyright © 2017 Захар. All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var partyRocks = [PartyRock]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 = PartyRock(imageURL: "https://www.sunhome.ru/i/wallpapers/200/planeta-zemlya-kartinka.960x540.jpg", videoURl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/bB6UGAMZbLQ\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Video 1")
        
        let p2 = PartyRock(imageURL: "https://i.mycdn.me/image?id=850260497968&t=3&plc=WEB&tkn=*HzR6H2waoPHFbmptGtcjCErDiFo", videoURl: "<iframe width=\"560\" height=\"315\" src=\"https://www.youtube.com/embed/9h3OQ_skcHg\" frameborder=\"0\" allowfullscreen></iframe>", videoTitle: "Video 2")
        
        partyRocks.append(p1)
        partyRocks.append(p2)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as? PartyCell {
            
            cell.updateUI(partyRock: partyRocks[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyRocks.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let partyRock = partyRocks[indexPath.row]
        
        performSegue(withIdentifier: "From MainVC To VideoVC", sender: partyRock)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? VideoVC {
            if let party = sender as? PartyRock {
                destination.partyRock = party
            }
        }
    }
}

