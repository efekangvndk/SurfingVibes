
import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var userNameText: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var comentLabel: UILabel!
    @IBOutlet var userUploadImageView: UIImageView!
    @IBOutlet var userImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func likeButton(_ sender: Any) {
    }
}
