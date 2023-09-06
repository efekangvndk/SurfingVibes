import UIKit
import Firebase


class ViewController: UIViewController {

   
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var emailText: UITextField!
    @IBOutlet var surfingVibes: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        //---------BackGround & Assets & Gif-----------
        let surfingGif = UIImage.gifImageWithName("surfingVibes")
        surfingVibes.image = surfingGif
        //---------------------------------------------
    }
    @IBAction func loginButton(_ sender: Any) {
        if emailText.text != "" && passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authData, error in
                if error != nil {
                    self.makeAlert(title: "Eksik Veya Hatalı Bilgi!", message: error?.localizedDescription ?? "Lütfen Tekrar Deneyin!")
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)

                }
            }
        }else {
            makeAlert(title: "Eksik Veya Hatalı Bilgi!", message: "Lütfen Tekrar Deneyin!")
        }
    }
    
    func makeAlert(title: String , message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true )
    }
    @IBAction func signupButton(_ sender: Any) {
    }
}

