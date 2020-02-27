//
//  TflAPIClient.swift
//  TflChallenge
//
//  Created by RAjeev Kumar on 25/02/2020.
//  Copyright © 2020 RAjeev Singh. All rights reserved.
//


import UIKit
import Alamofire

final class TflAPIClient: NSObject {
    private let appId: String
    private let appKey: String
    private let baseUrl = "https://api.tfl.gov.uk"
    
    init(appId: String, appKey: String) {
        self.appId = appId
        self.appKey = appKey
    }
    
    func requestRoadStatus(
        road: String,
        completionHandler: @escaping (DataResponse<[RoadStatus]>) -> Void) -> Void {
        
        let url = "\(baseUrl)/Road/\(road)"
        let parameters: Parameters = [
            "app_id": appId,
            "app_key": appKey
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseCollection { response in
            completionHandler(response)
        }
    }
    
}
