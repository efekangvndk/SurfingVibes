//
//  SaveViewController.swift
//  SocialMediaFirebase
//
//  Created by Efekan Güvendik on 3.08.2023.
//

import UIKit
import Firebase

class SaveViewController: UIViewController {

    @IBOutlet var saveEmailText: UITextField!
    @IBOutlet var smileGif: UIImageView!
    @IBOutlet var savePasswordAgainText: UITextField!
    @IBOutlet var savePasswordText: UITextField!
    @IBOutlet var saveNameText: UITextField!
    @IBOutlet var saveNickText: UITextField!
    @IBOutlet var savePhoneText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let smilegif = UIImage.gifImageWithName("smileGif")
        smileGif.image = smilegif
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        performSegue(withIdentifier: "toSaveBackVC", sender: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if saveEmailText.text != "" && saveNameText.text != "" && savePasswordText.text != "" && saveNickText.text != "" {
            Auth.auth().createUser(withEmail: saveEmailText.text! , password: savePasswordText.text!) { authdata, error in
                if error != nil {
                    self.makeAlert(title: "Eksik Veya Hatalı Bilgi!", message: error?.localizedDescription ?? "Lütfen Bilgileri Düzgünce Doldurunuz!")
                }else if self.savePasswordText.text != self.savePasswordAgainText.text{
                    self.makeAlert(title: "Error!", message: "Şifreniz Aynı Değil Lütfen Tekrar Deneyin!")

                }else{
                    self.performSegue(withIdentifier: "toFeed2VC", sender: nil)

                }
            }
        }else {
            makeAlert(title: "Eksik Veya Hatalı Bilgi!", message: "Lütfen Bilgileri Düzgünce Doldurunuz!")
        }
    }
    
    func makeAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true )
    }

}
