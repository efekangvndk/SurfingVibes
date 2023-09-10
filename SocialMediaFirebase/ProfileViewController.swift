//
//  ProfileViewController.swift
//  SocialMediaFirebase
//
//  Created by Efekan Güvendik on 9.08.2023.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController , UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    @IBOutlet var surfingGif: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImage.isUserInteractionEnabled = true
        let imageTabRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(selectImage2))
        profileImage.addGestureRecognizer(imageTabRecognizer2)
        
        let photoGif2 = UIImage.gifImageWithName("surfing gif")
        surfingGif.image = photoGif2
    }
    @objc func selectImage2(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker , animated: true)
    }

}
