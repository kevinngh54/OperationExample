//
//  LoanBO.swift
//  Examination2
//
//  Created by NHK on 11/11/20.
//  Copyright © 2020 NHK. All rights reserved.
//

import Foundation
import ObjectMapper

class AlbumContainerBO: BaseBO {
    var albums: [AlbumBO] = []
    
    override func mapping(map: Map) {
        albums <- map["albums"]
    }
}

class AlbumBO: BaseBO {
    var id = 0
    var title = ""
    
    override func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
    }
}
