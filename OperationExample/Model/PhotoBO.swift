//
//  PhotoBO.swift
//  OperationExample
//
//  Created by NHK on 3/9/21.
//  Copyright © 2021 NHK. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoContainerBO: BaseBO {
    var photos: [PhotoBO] = []
    
    override func mapping(map: Map) {
        photos <- map["photos"]
    }
}

class PhotoBO: BaseBO {
    var albumId = 0
    var id = 0
    var title = ""
    var url = ""
    var thumbnailUrl = ""
    
    override func mapping(map: Map) {
        albumId <- map["albumId"]
        id <- map["id"]
        title <- map["title"]
        url <- map["url"]
        thumbnailUrl <- map["thumbnailUrl"]
    }
}
