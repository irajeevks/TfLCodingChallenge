//
//  TflChallengeTests.swift
//  TflChallengeTests
//
//  Created by RAjeev Kumar on 25/02/2020.
//  Copyright © 2020 RAjeev Singh. All rights reserved.
//



import XCTest
import Alamofire
import SwiftyJSON
@testable import TflChallenge
 
class TflChallengeTests: XCTestCase {
    
    func testValidRequest() {
        // Use expectation to wait for res completion handler
        let e = expectation(description: "tfl_api")
        let api = TflAPIClient(appId: Constants.appId, appKey: Constants.appKey)
        let validRoad = "A1"
        
        api.requestRoadStatus(road: validRoad) { response in
            if let roadStatus = response.result.value?.first {
                XCTAssert(validRoad == roadStatus.displayName, "Display name should be equal to request road name")
                XCTAssertNotNil(roadStatus.statusSeverity)
                XCTAssertNotNil(roadStatus.statusSeverityDescription)
            }
            e.fulfill()
        }
        waitForExpectations(timeout: 7.0, handler: nil)
    }
    
    func testInvalidRequest() {
        // Use expectation to wait for res completion handler
        let e = expectation(description: "tfl_api")
        let api = TflAPIClient(appId: Constants.appId, appKey: Constants.appKey)
        let invalidRoad = "A999"
        
        api.requestRoadStatus(road: invalidRoad) { response in
            switch response.result {
            case .success:
                XCTFail("Invalid road name should not be successful")
            case .failure(let error):
                if let tflAPIError = error as? TflAPIError {
                    switch tflAPIError {
                    case .notFound:
                        e.fulfill()
                    default:
                        XCTFail("Error should have been caught as 'not found'")
                    }
                }
            }
        }
        waitForExpectations(timeout: 7.0, handler: nil)
    }
    
    
}
