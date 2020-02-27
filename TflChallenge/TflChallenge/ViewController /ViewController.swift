//
//  ViewController.swift
//  TflChallenge
//
//  Created by RAjeev Kumar on 25/02/2020.
//  Copyright © 2020 RAjeev Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar! { didSet { searchBar.delegate = self } }
    @IBOutlet weak var titlesView: UIView! { didSet { titlesView.isHidden = true } }
    @IBOutlet weak var roadDisplayNameLabel: UILabel!
    @IBOutlet weak var roadStatusLabel: UILabel!
    @IBOutlet weak var roadStatusDescriptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! { didSet { activityIndicator.hidesWhenStopped = true } }

    
    let api = TflAPIClient(appId: Constants.appId, appKey: Constants.appKey)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let roadName = searchBar.text {
            search(roadName: roadName)
        }
    }
    
    func search(roadName: String) {
        clear()
        activityIndicator.startAnimating()
        api.requestRoadStatus(road: roadName) { response in
            
            self.activityIndicator.stopAnimating()
            
            switch response.result {
            case .success:
                if let roadStatus = response.result.value?.first {
                    self.titlesView.isHidden = false
                    self.roadDisplayNameLabel.text = roadStatus.displayName
                    self.roadStatusLabel.text = roadStatus.statusSeverity
                    self.roadStatusDescriptionLabel.text = roadStatus.statusSeverityDescription
                }
            case .failure(let error):
                if let tflAPIError = error as? TflAPIError {
                    switch tflAPIError {
                    case .notFound:
                        self.errorLabel.text = Constants.Messages.notFoundError
                    default:
                        self.errorLabel.text = Constants.Messages.genericError
                    }
                }
            }
        }
    }
    
    func clear() {
        titlesView.isHidden = true
        roadDisplayNameLabel.text = ""
        roadStatusLabel.text = ""
        roadStatusDescriptionLabel.text = ""
        errorLabel.text = ""
    }

}
