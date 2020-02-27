//
//  RoadStatus.swift
//  TflChallenge
//
//  Created by RAjeev Kumar on 25/02/2020.
//  Copyright © 2020 RAjeev Singh. All rights reserved.
//

import Foundation
import Alamofire


struct RoadStatus: ResponseObjectSerializable, ResponseCollectionSerializable, CustomStringConvertible {
    let id: String
    let displayName: String
    let statusSeverity: String
    let statusSeverityDescription: String
    let bounds: String
    let envelope: String
    let url: NSURL
    
    
    var description: String {
        return ""
    }
    
    init?(response: HTTPURLResponse, representation: Any) {
        guard
            let representation = representation as? [String: Any],
            let id = representation["id"] as? String,
            let displayName = representation["displayName"] as? String,
            let statusSeverity = representation["statusSeverity"] as? String,
            let statusSeverityDescription = representation["statusSeverityDescription"] as? String,
            let bounds = representation["bounds"] as? String,
            let envelope = representation["bounds"] as? String,
            let urlStr = representation["url"] as? String,
            let url = NSURL(string: urlStr)
            else { return nil }
        
        self.id = id
        self.displayName = displayName
        self.statusSeverity = statusSeverity
        self.statusSeverityDescription = statusSeverityDescription
        self.bounds = bounds
        self.envelope = envelope
        self.url = url
    }
}

