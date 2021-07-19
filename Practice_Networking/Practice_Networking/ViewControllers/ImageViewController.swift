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
    
    private let navigationItemTitle = "Download Image"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationItemTitle
        downloadImage()
    }
    
    
    private func downloadImage() {
        
        guard let url = URL(string: "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg") else {return}
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.activityIndicator.stopAnimating()
                }
            }
        }.resume()
    }
    
}
