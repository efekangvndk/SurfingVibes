//
//  SettingsViewController.swift
//  SocialMediaFirebase
//
//  Created by Efekan Güvendik on 3.08.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func logauotBoutton(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "toViewControllerLogout", sender: nil)
        } catch {
            print("error")
        }
    }
    
    
}
