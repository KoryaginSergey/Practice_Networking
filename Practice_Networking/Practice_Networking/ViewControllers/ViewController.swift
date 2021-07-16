//
//  ViewController.swift
//  Practice_Networking
//
//  Created by anna on 8/15/19.
//  Copyright © 2019 NIX Solitions. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    var dataModel = [DataModel]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Network"
        
    }
    
    //MARK: - Actions

    @IBAction func downloadImageButton(_ sender: UIButton) {

        guard let imageVC = storyboard?.instantiateViewController(identifier: String(describing: ImageViewController.self)) as? ImageViewController else {return}
        navigationController?.pushViewController(imageVC, animated: true)
    }
    
    @IBAction func getDataButton(_ sender: Any) {
        callGetRequest()
    }
    
    @IBAction func postDataButton(_ sender: Any) {
        callPostRequest()
    }
    
    @IBAction func allDataButton(_ sender: UIButton) {
        guard let allDataVC = storyboard?.instantiateViewController(identifier: String(describing: AllDataViewController.self)) as? AllDataViewController else {return}
        allDataVC.models = dataModel
        
        navigationController?.pushViewController(allDataVC, animated: true)
        
    }
    
    //MARK: - Private funcs
    
    private func callGetRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let response = response, let data = data else {return}
            print(response)
            print(data)
            
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                print(json)
//            } catch {
//                print(error)
//            }
            do {
                self.dataModel = try JSONDecoder().decode([DataModel].self, from: data)
            
            } catch {
                print(error)
                
            }
        }.resume()
    }
    
    private func callPostRequest() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else {return}
        
        let userData = ["Course" : "Networking", "Task" : "GET and POST requests"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData, options: [])
        else {return}
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let response = response, let data = data else {return}
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    
    
    
    
    
    
}

