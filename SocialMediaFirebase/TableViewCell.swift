
import UIKit

class TableViewCell: UITableViewCell{

    var imageToSend: UIImage?
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
    }
    @IBAction func likeButton(_ sender: Any) {
    }
}
