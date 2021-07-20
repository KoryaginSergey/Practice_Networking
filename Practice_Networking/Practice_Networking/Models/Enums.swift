//
//  Enums.swift
//  Practice_Networking
//
//  Created by Alex Korygin on 19.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import Foundation

enum NavigationTitle: CustomStringConvertible {
    case main
    case image
    case all
    
    var description: String {
        switch self {
        case .main:
            return "Network"
        case .image:
            return "Download image"
        case .all:
            return "All data"
        }
    }
}
