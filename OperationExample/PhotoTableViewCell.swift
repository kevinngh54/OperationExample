//
//  PhotoTableViewCell.swift
//  OperationExample
//
//  Created by NHK on 3/14/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    func bindPhotoData(title: String) {
        titleLabel.text = title
        totalLabel.text = nil
    }
    
    func bindAlbumData(title: String, total: Int) {
        titleLabel.text = title
        totalLabel.text = "\(total)"
    }
}
