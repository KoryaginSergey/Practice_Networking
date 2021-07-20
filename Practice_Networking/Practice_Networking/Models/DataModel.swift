//
//  DataModel.swift
//  Practice_Networking
//
//  Created by Admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import Foundation

class DataModel: Decodable {
    let body: String
    let id: Int
    let title: String
    let userId: Int
    
    init(body: String, id: Int, title: String, userId: Int) {
        self.body = body
        self.id = id
        self.title = title
        self.userId = userId
    }
}
