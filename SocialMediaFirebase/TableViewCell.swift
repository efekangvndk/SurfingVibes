
import UIKit
import Firebase

class TableViewCell: UITableViewCell{
    
    var imageToSend: UIImage?
    @IBOutlet var documentIDLabel: UILabel!
    @IBOutlet var userNameText: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var comentLabel: UILabel!
    @IBOutlet var disLikeLabel: UILabel!
    @IBOutlet var userUploadImageView: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let receivedImage = imageToSend {
            userImageView.image = receivedImage // UIImageView'a gönderilen görüntüyü atayabilirsiniz
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func disLikeButton(_ sender: Any) {
        let fireStoreDatabaseDislike = Firestore.firestore()
        if let currentDislikeCount = Int(disLikeLabel.text!) {
            let newDislikeCount = currentDislikeCount + 1
            
            let dislikeData = ["dislike": newDislikeCount] as [String : Any]
            fireStoreDatabaseDislike.collection("Posts").document(documentIDLabel.text!).setData(dislikeData, merge: true) { error in
                if let error = error {
                    print("Dislike güncelleme hatası: \(error.localizedDescription)")
                } else {
                    print("Dislike başarıyla güncellendi!")
                    self.disLikeLabel.text = "\(newDislikeCount)"
                }
            }
        } else {
            print("Dislike sayısı dönüştürülürken bir hata oluştu.")
        }
    }
    
    @IBAction func likeButton(_ sender: Any) {
        let fireStoreDataBaselike = Firestore.firestore()
        if let currentLikeCount = Int(likeLabel.text!) {
            let newLikeCount = currentLikeCount + 1
            
            let likeData = ["like": newLikeCount] as [String : Any]
            fireStoreDataBaselike.collection("Posts").document(documentIDLabel.text!).setData(likeData, merge: true) { error in
                if let error = error {
                    print("Like güncelleme hatası: \(error.localizedDescription)")
                } else {
                    print("Like başarıyla güncellendi!")
                    self.likeLabel.text = "\(newLikeCount)"
                }
            }
        } else {
            print("Like sayısı dönüştürülürken bir hata oluştu.")
        }
    }
}
