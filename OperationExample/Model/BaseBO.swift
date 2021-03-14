//
//  BaseBO.swift
//  Examination1
//
//  Created by NHK on 10/2/20.
//  Copyright © 2020 NHK. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseBO: Mappable {
    required init?(map: Map) {}
    func mapping(map: Map) {}
}
