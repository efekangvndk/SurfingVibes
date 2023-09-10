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
    @IBOutlet var bioCommentText: UITextField!
    
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
    @IBAction func saveButton(_ sender: Any) {
        // Burda da profile imagemizi kayıt etmek için tekrar auth kullanarak storage kayıt ediıyoruz.
        
        let commentText = bioCommentText.text ?? ""
        
        let storage = Storage.storage()
        let storageReference2 = storage.reference()
    
        let ProfileFolderMedia = storageReference2.child("profile picture")
        
        if let commentData = commentText.data(using: .utf8){
            let profileImageRef = ProfileFolderMedia.child("profile jpeg").child("profile comment")
            profileImageRef.putData(commentData) { metadata, error in
                if let error = error {
                    // Hata durumunda işlemleri burada işlemleri
                    print("Hata: \(error.localizedDescription)")
                    } else {
                    // Yükleme başarılı olduğunda işlemleri burada yapılabilir
                    print("Comment metni başarıyla kaydedildi!")
                }
            }
        }
        
        if let data = profileImage.image?.jpegData(compressionQuality: 0.5){
            
            let profileImageRef = ProfileFolderMedia.child("profile jpeg")
            profileImageRef.putData(data) { metadata, error in
                if let error = error {
                    // Hata durumunda işlemleri burada işleyebilirsiniz
                    print("Hata: \(error.localizedDescription)")
                } else {
                    // Yükleme başarılı olduğunda işlemleri burada yapabilirsiniz
                    print("Profil resmi başarıyla kaydedildi!")
                }
            }
        } else {
            // Eğer bir profil resmi seçilmemişse, uygun bir hata işlemi yapabilirsiniz
            print("Lütfen bir profil resmi seçin.")
        }
            }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage{
            profileImage.image = selectedImage
        }
        picker.dismiss(animated: true)
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
                picker.dismiss(animated: true, completion: nil)
            }
    }

        }
        
    
