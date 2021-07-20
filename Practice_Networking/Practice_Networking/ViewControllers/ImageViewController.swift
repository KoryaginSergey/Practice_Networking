//
//  ImageViewController.swift
//  Practice_Networking
//
//  Created by Admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit


class ImageViewController: UIViewController {
    
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    private let imagePath = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"

    override func viewDidLoad() {
        super.viewDidLoad()
        
       navigationItem.title = NavigationTitle.image.description
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        downloadImage()
    }
    
    private func downloadImage() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        NetworkManager.send(path: imagePath, method: RequestMethod.get.description, params: nil) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
}
