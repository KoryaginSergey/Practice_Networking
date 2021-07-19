//
//  AllDataViewController.swift
//  Practice_Networking
//
//  Created by Admin on 16.07.2021.
//  Copyright © 2021 NIX Solitions. All rights reserved.
//

import UIKit


class AllDataViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var models = [DataModel]()
    private let cellID = String(describing: ModelTableViewCell.self)
    private let navigationItemTitle = "All Data View Controller"
    private let defaultHeightForRow: CGFloat = 100
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = navigationItemTitle
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

    //MARK: - Extensions

extension AllDataViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return defaultHeightForRow
    }
}

extension AllDataViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ModelTableViewCell
    
        let model = self.models[indexPath.row]

        cell.idLable.text = String(model.id)
        cell.titleLable.text = model.title
        
        return cell
    }
}
