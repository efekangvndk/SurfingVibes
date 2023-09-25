
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
        var likeStore = [Int()]
        var likeCount = [Int()]
        
        super.awakeFromNib()
        if let receivedImage = imageToSend {
            userImageView.image = receivedImage
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBAction func disLikeButton(_ sender: Any) {
        let fireStoreDatabaseDislike = Firestore.firestore()
        if let DislikeCount = Int(disLikeLabel.text!) {
                let dislikeStore = ["dislike": DislikeCount + 1 ] as [String : Any]
                fireStoreDatabaseDislike.collection("Posts").document(documentIDLabel.text!).setData(dislikeStore, merge: true)
            }
        }
    
    
        
        @IBAction func likeButton(_ sender: Any) {
            let fireStoreDataBaselike = Firestore.firestore()
            if let likeCount = Int(likeLabel.text!){
                let likesStore = ["likes": likeCount + 1 ] as [String: Any]
                fireStoreDataBaselike.collection("Posts").document(documentIDLabel.text!).setData(likesStore, merge: true)
            }
        }
    }
