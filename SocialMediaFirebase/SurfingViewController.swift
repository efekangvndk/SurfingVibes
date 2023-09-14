import UIKit
import Firebase
import SDWebImage

class SurfingViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray = [Int]()
    var disLikeArray = [Int]()
    var userımageArray = [String]()
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self   //burda aşşaığda oluşturduğumuz temsilcileri ve kaynak kodu
        tableView.dataSource = self //Super viewdidLoad içinde uygulama açıldığında bir kez olmak üzere çalıştırmak için çağırıyoruz.
        
        getDataFromFirestore()      //Aynı şekilde getData fonksiyonumuzuda.
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        fireStoreDatabase.collection("Posts").addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription)
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userımageArray.removeAll(keepingCapacity: false)
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.userCommentArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.disLikeArray.removeAll(keepingCapacity: false)
                    
                    
                    for document in  snapshot!.documents{     // Alandaki işlemler uploadladığımız görseli kimin ve hangi görsel olduğunu-
                        let documentID = document.documentID  // Gösterip veriyi çekmek ve kullanıcıya surfing ekranında göstermek.
                        if let postedBy = document.get("PostedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        if let postredComment = document.get("PostComment") as? String{
                            self.userCommentArray.append(postredComment)
                        }
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let dislikes = document.get("dislike") as? Int{
                            self.disLikeArray.append(dislikes)
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            self.userımageArray.append(imageUrl)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell" , for: indexPath) as! TableViewCell
            cell.userNameText.text = userEmailArray[indexPath.row]
            cell.comentLabel.text = userCommentArray[indexPath.row]    // Bu alandaki işlemlerimiz ekrandaki değerlerin ilk gösterimleri
            cell.likeLabel.text = String(likeArray[indexPath.row])
            cell.disLikeLabel.text = String(disLikeArray[indexPath.row])
            cell.userImageView.image = UIImage(named: "person.png")
            cell.userUploadImageView.sd_setImage(with: URL(string: self.userımageArray[indexPath.row]))
        return cell
        
    }
    
}
