//
//  UIImageViewExtension.swift
//  alamofireTest
//
//  Created by Furkan Yıldız on 25.06.2021.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(imageUrl: String){
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
