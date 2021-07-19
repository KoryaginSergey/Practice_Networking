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
    
    
    var dataModel = [DataModel]()
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
   
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
    
    @IBAction func addImageInIngureButton(_ sender: Any) {
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - Private funcs
    
    private func callGetRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
            else {return}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in
            guard let _ = response, let data = data else {return}
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
            guard let _ = response, let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func sendToServer(data: Data) {
        let base64Image = data.base64EncodedString()
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: "https://api.imgur.com/3/image")!)
        request.addValue("Client-ID 5af4a79c42ea7df", forHTTPHeaderField: "Authorization")
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"

        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"image\""
        body += "\r\n\r\n\(base64Image)\r\n"
        body += "--\(boundary)--\r\n"
        
        let postData = body.data(using: .utf8)

        request.httpBody = postData

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {return}
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print(error)
            }
            self.endBackgroundTask()
        }.resume()
    }
    
    func registerBackgroundTask() {
      backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
        self?.endBackgroundTask()
      }
      assert(backgroundTask != .invalid)
    }
      
    func endBackgroundTask() {
      UIApplication.shared.endBackgroundTask(backgroundTask)
      backgroundTask = .invalid
    }
}

    //MARK: - Extensions

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        var data = image.jpegData(compressionQuality: 1.0)

        let mb10 = 10000000.0
        if Double(data!.count) > mb10 {
            let compQuality: Double = mb10 / Double(data!.count)
            data = image.jpegData(compressionQuality: CGFloat(compQuality))
        }
        
        self.registerBackgroundTask()
        self.sendToServer(data: data!)
        
        picker.dismiss(animated: true, completion: nil)
    }
}


