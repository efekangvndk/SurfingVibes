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
        
        
        // Metin alanlarından veriyi güvenli bir şekilde alalım.
        if let passwordAgainText = savePasswordAgainText?.text,
           let passwordText = savePasswordText?.text,
           let nameText = saveNameText?.text,
           let emailText = saveEmailText?.text,
           let nickText = saveNickText?.text,
           let phoneText = savePhoneText?.text {

            // Verileri tek bir metin olarak birleştirme işlemi (örneğin, bir satırda).
            let combinedText = """
                Password Again: \(passwordAgainText)
                Password: \(passwordText)
                Name: \(nameText)
                Email: \(emailText)
                Nickname: \(nickText)
                Phone: \(phoneText)
                """

            // Firebase Storage'a kayıt işlemleri (combinedText'i kullanarak yukarıdaki örnek kodu kullanalım).
            let storage = Storage.storage()
            let textData = combinedText.data(using: .utf8) ?? Data() // Data türünü unwrap edin veya varsayılan bir değer kullanım hali
            let textRef = storage.reference().child("kullanici_metin.txt")
            
            textRef.putData(textData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Hata: \(error.localizedDescription)")
                } else {
                    print("Yükleme başarılı!")
                }
            }

        } else {
            // Eğer bir veya daha fazla metin alanı boşsa, uygun hata işlemlerini burada yapabiliriz.
            print("Bir veya daha fazla metin alanı boş.") // Güvence amaçlı bir geri iletim print'i
        }
        
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
