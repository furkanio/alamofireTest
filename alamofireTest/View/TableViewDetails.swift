//
//  TableViewDetails.swift
//  spaceXtesting
//
//  Created by Furkan Yıldız on 27.06.2021.
//

import Foundation
import UIKit
import Kingfisher

class TableViewDetails : UIViewController {
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var detailMissionName: UILabel!
    @IBOutlet weak var letFlightNumber: UILabel!
    @IBOutlet weak var launchDateLabel: UILabel!
    @IBOutlet weak var rocketNameLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var value = "Detailed information about this launch could not be found."
        
    var selectedLaunch : Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.detailImage.setImage(imageUrl: self.selectedLaunch.links.mission_patch!)
        
        self.detailMissionName.text = self.selectedLaunch.mission_name
        
        self.letFlightNumber.text = "Flight Number : #0" + "\(String(describing: self.selectedLaunch.flight_number))"
        
        self.detailLabel.text = "Detail : " + self.selectedLaunch.details!
        
        self.launchDateLabel.text = "Launch Date : " + self.selectedLaunch.launch_date_local!
        
        self.rocketNameLabel.text = "Rocket : " + self.selectedLaunch.rocket.rocket_name!
        }
    }
    

