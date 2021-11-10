//
//  PhotosTableViewCell.swift
//  alamofireTest
//
//  Created by Furkan Yıldız on 23.06.2021.
//

import UIKit
import Kingfisher

final class PhotosTableViewCell: UITableViewCell {
 
    
    @IBOutlet private weak var photosImageView: UIImageView!
    @IBOutlet private weak var missionNameLabel: UILabel!
    @IBOutlet private weak var missionDateLabel: UILabel!
    @IBOutlet private weak var rocketNameLabel: UILabel!
    
    var launch : Model! {
        didSet{
            self.missionNameLabel.text = self.launch.mission_name
            self.missionDateLabel.text = self.launch.launch_year
            self.rocketNameLabel.text = self.launch.rocket.rocket_name
            self.photosImageView.setImage(imageUrl: self.launch.links.mission_patch!)
        }
    }

}
