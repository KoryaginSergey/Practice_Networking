//
//  NetworkManager.swift
//  Practice_Networking
//
//  Created by Admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import Foundation

enum RequestMethod: CustomStringConvertible {
    case get
    case post
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }

}

class NetworkManager {
    
    static func send(path: String, method: String, params: [String : Any]?, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: path) else {return}
                
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let parameters = params {
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            else {return}
            request.httpBody = httpBody
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume()
    }
    
}
