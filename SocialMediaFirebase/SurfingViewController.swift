//
//  SurfingViewController.swift
//  SocialMediaFirebase
//
//  Created by Efekan Güvendik on 3.08.2023.
//

import UIKit

class SurfingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! TableViewCell
        cell.userNameText.text = "User"
        cell.comentLabel.text = "Test"
        cell.likeLabel.text = "0"
        cell.disLikeLabel.text = "0"
        cell.userImageView.image = UIImage(named: "person.png")
        cell.userUploadImageView.image = UIImage(named: "person.png")
        return cell
    }
  

}
