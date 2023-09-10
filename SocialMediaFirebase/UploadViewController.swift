//
//  UploadViewController.swift
//  SocialMediaFirebase
//
//  Created by Efekan Güvendik on 3.08.2023.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet var uploadButton: UIButton!
    @IBOutlet var toLibrary: UIImageView!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var commentText: UITextField!
    @IBOutlet var gallery: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toLibrary.isUserInteractionEnabled = true
        let imageTabRecognizer = UITapGestureRecognizer(target: self, action: #selector(selecImage))
        toLibrary.addGestureRecognizer(imageTabRecognizer)
        
        let photoGif = UIImage.gifImageWithName("photo")
        gallery.image = photoGif
        
    }
    @objc func selecImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker , animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        toLibrary.image = info[.originalImage] as? UIImage
        uploadButton.isEnabled = true
        self.dismiss(animated: true)
    }
    
    func makeAlert(titleInput: String ,messageınput: String) {
        let alert = UIAlertController(title: titleInput, message: messageınput, preferredStyle: UIAlertController.Style.alert)
        let okButton1 = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton1)
        self.present(alert, animated: true)
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        
        let storage = Storage.storage() //.auth gibi o sınıfdan o objeyi kullan demek gibi ve bunun yanında bir referans oluşturucaz.
        let storageReference = storage.reference()//bu referansı kullanarak neyi nereye kayıt edicez onu ayarlıyoruz.
        
        let mediaFolder = storageReference.child("media")
        
        //bu veriyi kayıt etmek için bunu bir data şeklinde yazdırmamız lazım bunu da aşşağıdaki şekilde yapyıoruz.
        if let data = gallery.image?.jpegData(compressionQuality: 0.5){
            ///Burda upload ladığımız her bir birim için farkı bir url işlemi yaptırmamız lazım ki upload dan sonra birimler değişmesin kalsın.
            ///Bunu da UUID işlemi ile yapıcaz.
            let uuid = UUID().uuidString // her kullanımdan sonra unik bir uydurma kullanıcaz
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            imageReference.putData(data) { metadata, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error!", messageınput: error?.localizedDescription ?? "Error!")
                }else{
                    imageReference.downloadURL { (url, error) in
                        if let error = error {
                            // Handle error
                            print("Error fetching download URL: \(error)")
                        } else {
                            if let imageUrl = url?.absoluteString {
                                // Database operations using imageUrl
                                let fireStoreDatabase = Firestore.firestore()
                                var fireStoreReference: DocumentReference? = nil

                                let firestorePost = ["imageUrl": imageUrl, "PostedBy": Auth.auth().currentUser?.email! as Any,"PostName": self.nameText.text as Any ,"PostComment": self.commentText.text!, "date": FieldValue.serverTimestamp(), "likes": 0 ,"dislike" : 0] as [String: Any]
                                
                                fireStoreReference = fireStoreDatabase.collection ("Posts").addDocument (data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageınput : error?.localizedDescription ?? "Error")
                                }else{
                                    
                                    self.toLibrary.image = UIImage(named: "select.png")
                                    self.commentText.text = ""
                                    self.tabBarController?.selectedIndex = 0
                                }
                                })
                            }
                        }
                    }

                }
            }
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "toBackFeedVC", sender: nil)
    }
    @IBAction func toProfileButton(_ sender: Any) {
    }
   
}
